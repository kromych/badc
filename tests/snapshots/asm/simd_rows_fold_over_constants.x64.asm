
simd_rows_fold_over_constants.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	movl	<rip>, %eax # <addr>
               	vmovd	%eax, %xmm2
               	movl	<rip>, %eax # <addr>
               	vpinsrd	$0x1, %eax, %xmm2, %xmm2
               	movl	$0x7fff8000, %eax       # imm = 0x7FFF8000
               	vpinsrd	$0x2, %eax, %xmm2, %xmm2
               	movq	$-0x1, %rax
               	vpinsrd	$0x3, %eax, %xmm2, %xmm2
               	movl	<rip>, %eax # <addr>
               	subq	$0x12345677, %rax       # imm = 0x12345677
               	movswq	%ax, %rax
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	movq	$-0x2, %rax
               	vpinsrw	$0x1, %eax, %xmm3, %xmm3
               	movl	$0x3, %eax
               	vpinsrw	$0x2, %eax, %xmm3, %xmm3
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	vpinsrw	$0x3, %eax, %xmm3, %xmm3
               	movq	$-0x8000, %rax          # imm = 0x8000
               	vpinsrw	$0x4, %eax, %xmm3, %xmm3
               	movl	$0x6, %eax
               	vpinsrw	$0x5, %eax, %xmm3, %xmm3
               	movq	$-0x7, %rax
               	vpinsrw	$0x6, %eax, %xmm3, %xmm3
               	movl	$0x8, %eax
               	vpinsrw	$0x7, %eax, %xmm3, %xmm3
               	vpaddw	%xmm1, %xmm0, %xmm4
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm4, -0x60(%rbp)
               	vpaddw	%xmm3, %xmm2, %xmm4
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm4, -0x50(%rbp)
               	movl	$0x10, %edx
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movups	%xmm2, 0x40(%rsp)
               	movups	%xmm3, 0x50(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x5679, %eax           # imm = 0x5679
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0x7899, %eax           # imm = 0x7899
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpackssdw	%xmm15, %xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpackssdw	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x7fff, %eax           # imm = 0x7FFF
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x7fff, %eax           # imm = 0x7FFF
               	je	<addr>
               	movl	$0x66, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpackuswb	%xmm15, %xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpackuswb	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x800, %eax            # imm = 0x800
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpmulhw	%xmm15, %xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpmulhw	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0xfc4d, %eax           # imm = 0xFC4D
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0x4000, %eax           # imm = 0x4000
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x68, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	pshufd	$0x1b, %xmm14, %xmm0    # xmm0 = xmm14[3,2,1,0]
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	pshufd	$0x1b, %xmm14, %xmm0    # xmm0 = xmm14[3,2,1,0]
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0x7fff, %eax           # imm = 0x7FFF
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0xbcdf, %eax           # imm = 0xBCDF
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x1234, %eax           # imm = 0x1234
               	je	<addr>
               	movl	$0x69, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm0
               	pslld	$0x7, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm0
               	pslld	$0x7, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x3c00, %eax           # imm = 0x3C00
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0x4d5e, %eax           # imm = 0x4D5E
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0x6a, %eax
               	leave
               	retq
               	movups	0x30(%rsp), %xmm0
               	psraw	$0x3, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x50(%rsp), %xmm0
               	psraw	$0x3, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0xfff, %eax            # imm = 0xFFF
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0xf000, %eax           # imm = 0xF000
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6b, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpunpckhbw	%xmm15, %xmm14, %xmm0 # xmm0 = xmm14[8],xmm15[8],xmm14[9],xmm15[9],xmm14[10],xmm15[10],xmm14[11],xmm15[11],xmm14[12],xmm15[12],xmm14[13],xmm15[13],xmm14[14],xmm15[14],xmm14[15],xmm15[15]
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpunpckhbw	%xmm15, %xmm14, %xmm0 # xmm0 = xmm14[8],xmm15[8],xmm14[9],xmm15[9],xmm14[10],xmm15[10],xmm14[11],xmm15[11],xmm14[12],xmm15[12],xmm14[13],xmm15[13],xmm14[14],xmm15[14],xmm14[15],xmm15[15]
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0xf9ff, %eax           # imm = 0xF9FF
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0xff, %eax
               	je	<addr>
               	movl	$0x6c, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpsadbw	%xmm15, %xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpsadbw	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x4fa, %eax            # imm = 0x4FA
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0x374, %eax            # imm = 0x374
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6d, %eax
               	leave
               	retq
               	movups	0x30(%rsp), %xmm14
               	pabsw	%xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x50(%rsp), %xmm14
               	pabsw	%xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0x7fff, %eax           # imm = 0x7FFF
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x6e, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpmaddubsw	%xmm15, %xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpmaddubsw	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0x7a6e, %eax           # imm = 0x7A6E
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0xc000, %eax           # imm = 0xC000
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0x7f8, %eax            # imm = 0x7F8
               	je	<addr>
               	movl	$0x6f, %eax
               	leave
               	retq
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpcmpgtd	%xmm15, %xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x70, %eax
               	leave
               	retq
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpalignr	$0x5, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[5,6,7,8,9,10,11,12,13,14,15],xmm14[0,1,2,3,4]
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpalignr	$0x5, %xmm15, %xmm14, %xmm0 # xmm0 = xmm15[5,6,7,8,9,10,11,12,13,14,15],xmm14[0,1,2,3,4]
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0xff00, %eax           # imm = 0xFF00
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0xf900, %eax           # imm = 0xF900
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	cmpl	$0x8ff, %eax            # imm = 0x8FF
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	cmpl	$0xdf12, %eax           # imm = 0xDF12
               	je	<addr>
               	movl	$0x71, %eax
               	leave
               	retq
               	movups	0x30(%rsp), %xmm14
               	phminposuw	%xmm14, %xmm0
               	leaq	-0x60(%rbp), %rdi
               	movups	%xmm0, -0x60(%rbp)
               	movups	0x50(%rsp), %xmm14
               	phminposuw	%xmm14, %xmm0
               	leaq	-0x50(%rbp), %rsi
               	movups	%xmm0, -0x50(%rbp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movups	-0x50(%rbp), %xmm0
               	pextrw	$0x0, %xmm0, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	pextrw	$0x3, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x4, %xmm0, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	pextrw	$0x7, %xmm0, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x72, %eax
               	leave
               	retq
               	movups	0x40(%rsp), %xmm14
               	movups	0x50(%rsp), %xmm15
               	vpackssdw	%xmm15, %xmm14, %xmm0
               	pextrw	$0x3, %xmm0, %eax
               	cmpl	$0xffff, %eax           # imm = 0xFFFF
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
