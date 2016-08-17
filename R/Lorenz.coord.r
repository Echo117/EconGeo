#' Computes the coordinates used to plot a Lorenz curve from regional industrial counts
#'
#' This function computes the coordinates used to plot a Lorenz curve from regional industrial counts. This curve gives an indication of the unequal distribution of an industry accross regions.
#' @param mat An incidence matrix with regions in rows and industries in columns. The input can also be a vector of industrial regional count (a matrix with n regions in rows and a single column).
#' @keywords concentration inequality
#' @export
#' @examples
#' ## generate vectors of industrial count
#' ind <- c(0, 10, 10, 30, 50)
#'
#' ## run the function
#' Lorenz.coord (ind)
#'
#'## plot the coordinates returned by the function to draw a Lorenz curve
#' plot (Lorenz.coord (ind)$cum.reg, Lorenz.coord (ind)$cum.out,
#' type = "l", main = "Lorenz curve",
#' xlab="Cumulative proportion of regions",
#' ylab="Cumulative proportion of industrial output",
#' xlim=c(0, 1), ylim=c(0, 1))
#' abline (0,1, col = "red")
#'
#' ## generate a region - industry matrix
#' mat = matrix (
#' c (0, 1, 0, 0,
#' 0, 1, 0, 0,
#' 0, 1, 0, 0,
#' 0, 1, 0, 1,
#' 0, 1, 1, 1), ncol = 4, byrow = T)
#' rownames(mat) <- c ("R1", "R2", "R3", "R4", "R5")
#' colnames(mat) <- c ("I1", "I2", "I3", "I4")
#'
#' ## run the function by aggregating all industries
#' Lorenz.coord (rowSums(mat))
#'
#' ## run the function for industry #1 only (perfect equality)
#' Lorenz.coord (mat[,1])
#'
#' ## run the function for industry #2 only (perfect equality)
#' Lorenz.coord (mat[,2])
#'
#' ## run the function for industry #3 only (perfect unequality)
#' Lorenz.coord (mat[,3])
#'
#' ## run the function for industry #4 only (top 40% produces 100% of the output)
#' Lorenz.coord (mat[,4])
#'
#' @author Pierre-Alexandre Balland \email{p.balland@uu.nl}
#' @seealso \code{\link{Hoover.Gini}}, \code{\link{locational.Gini}}, \code{\link{locational.Gini.curve}}, \code{\link{Hoover.curve}}, \code{\link{Gini}}
#' @references Lorenz, M. O. (1905) Methods of measuring the concentration of wealth, \emph{Publications of the American Statistical Association} \strong{9}: 209–219

Lorenz.coord <- function(mat) {

  mat = as.matrix (mat)

    x <- mat[,1]
    x = x[complete.cases (x)]
    weights = rep(1, length = length(x))
    ox <- order(x)
    x <- x[ox]
    weights <- weights[ox]/sum(weights)
    p <- cumsum(weights)
    nu <- cumsum(weights * x)
    n <- length(nu)
    nu <- nu/nu[n]
    p <- c(0,p)
    nu <- c(0,nu)
    return (list(cum.reg = p, cum.out = nu))

  }

