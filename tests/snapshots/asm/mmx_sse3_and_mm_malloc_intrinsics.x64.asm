
mmx_sse3_and_mm_malloc_intrinsics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<mmx>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movw	$0x1, -0x8(%rbp)
               	movw	$0x2, -0x6(%rbp)
               	movw	$0x3, -0x4(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movw	$0x4, -0x2(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x20001, %eax          # imm = 0x20001
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	$0x0, (%rcx)
               	movl	$0x5, -0x8(%rbp)
               	movl	$0x7, -0x4(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movabsq	$0x700000005, %r11      # imm = 0x700000005
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %r9
               	movq	$0x0, (%r9)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x2, -0x7(%rbp)
               	movb	$0x3, -0x6(%rbp)
               	movb	$0x4, -0x5(%rbp)
               	movb	$0x5, -0x4(%rbp)
               	movb	$0x6, -0x3(%rbp)
               	movb	$0x7, -0x2(%rbp)
               	movb	$0x8, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x807060504030201, %r11 # imm = 0x807060504030201
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movb	$0x7f, -0x8(%rbp)
               	movb	$0x7f, -0x4(%rbp)
               	movb	$-0x80, -0x7(%rbp)
               	movb	$-0x80, -0x3(%rbp)
               	movb	$0x5, -0x6(%rbp)
               	movb	$0x7f, -0x2(%rbp)
               	movb	$-0x5, -0x5(%rbp)
               	movb	$-0x80, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x7f807f8004fa7f81, %r11 # imm = 0x807F807FFB05807F
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movb	$-0x1, -0x8(%rbp)
               	movb	$-0x1, -0x4(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	movb	$0x0, -0x3(%rbp)
               	movl	$0x5, %eax
               	movb	%al, -0x6(%rbp)
               	movb	$-0x80, -0x2(%rbp)
               	movb	$-0x1, -0x5(%rbp)
               	movb	$0x0, -0x1(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movabsq	$0x8000ffff0500ff, %r11 # imm = 0x8000FFFF0500FF
               	cmpq	%r11, %rcx
               	je	<addr>
               	leave
               	retq
               	movw	$0x7fff, -0x8(%rbp)     # imm = 0x7FFF
               	movw	$0x1, -0x4(%rbp)
               	movw	$0x8000, -0x6(%rbp)     # imm = 0x8000
               	movw	$0xffff, -0x2(%rbp)     # imm = 0xFFFF
               	movq	-0x8(%rbp), %rdx
               	movabsq	$-0xfffe7fff8001, %r11  # imm = 0xFFFF000180007FFF
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %r9
               	movq	$0x0, (%r9)
               	movb	$0x1, -0x10(%rbp)
               	movb	$0x2, -0xf(%rbp)
               	movb	$0x3, -0xe(%rbp)
               	movb	$0x4, -0xd(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, -0xc(%rbp)
               	movb	$0x6, -0xb(%rbp)
               	movb	$0x7, -0xa(%rbp)
               	movb	$0x8, -0x9(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	$0x0, (%rcx)
               	movb	$0xb, -0x10(%rbp)
               	movb	$0xc, -0xf(%rbp)
               	movb	$0xd, -0xe(%rbp)
               	movb	$0xe, -0xd(%rbp)
               	movb	$0xf, -0xc(%rbp)
               	movb	$0x10, -0xb(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movb	$0x11, -0xa(%rbp)
               	movb	$0x12, -0x9(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x28(%rbp), %rsi
               	movq	(%rcx), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x20(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movq	$0x0, (%rax)
               	movsbq	-0x20(%rbp), %rax
               	movb	%al, -0x10(%rbp)
               	movsbq	-0x18(%rbp), %rax
               	movb	%al, -0xf(%rbp)
               	movsbq	-0x1f(%rbp), %rax
               	movb	%al, -0xe(%rbp)
               	movsbq	-0x17(%rbp), %rax
               	movb	%al, -0xd(%rbp)
               	movsbq	-0x1e(%rbp), %rax
               	movb	%al, -0xc(%rbp)
               	movsbq	-0x16(%rbp), %rax
               	movb	%al, -0xb(%rbp)
               	movsbq	-0x1d(%rbp), %rax
               	movb	%al, -0xa(%rbp)
               	movsbq	-0x15(%rbp), %rax
               	leaq	-0x10(%rbp), %rdx
               	movb	%al, -0x9(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0xe040d030c020b01, %r11 # imm = 0xE040D030C020B01
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x20(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	$0x0, (%rdx)
               	movsbq	-0x1c(%rbp), %rax
               	movb	%al, -0x10(%rbp)
               	movsbq	-0x14(%rbp), %rax
               	movb	%al, -0xf(%rbp)
               	movsbq	-0x1b(%rbp), %rax
               	movb	%al, -0xe(%rbp)
               	movsbq	-0x13(%rbp), %rax
               	movb	%al, -0xd(%rbp)
               	movsbq	-0x1a(%rbp), %rax
               	movb	%al, -0xc(%rbp)
               	movsbq	-0x12(%rbp), %rax
               	movb	%al, -0xb(%rbp)
               	movsbq	-0x19(%rbp), %rax
               	movb	%al, -0xa(%rbp)
               	movsbq	-0x11(%rbp), %rax
               	movb	%al, -0x9(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x1208110710060f05, %r11 # imm = 0x1208110710060F05
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movw	$0x1, -0x30(%rbp)
               	movw	$0x2, -0x2e(%rbp)
               	movw	$0x3, -0x2c(%rbp)
               	movw	$0x4, -0x2a(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movw	$0x5, -0x28(%rbp)
               	movw	$0x6, -0x26(%rbp)
               	movw	$0x7, -0x24(%rbp)
               	movw	$0x8, -0x22(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, (%rax)
               	movswq	-0x1c(%rbp), %rax
               	movw	%ax, -0x10(%rbp)
               	movswq	-0x14(%rbp), %rax
               	movw	%ax, -0xe(%rbp)
               	movswq	-0x1a(%rbp), %rax
               	movw	%ax, -0xc(%rbp)
               	movswq	-0x12(%rbp), %rax
               	movw	%ax, -0xa(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x8000400070003, %r11  # imm = 0x8000400070003
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x1, -0x30(%rbp)
               	movl	$0x2, -0x2c(%rbp)
               	movl	$0x3, -0x28(%rbp)
               	movl	$0x4, -0x24(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	movl	$0x1, -0x20(%rbp)
               	movl	$0x3, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rcx
               	movabsq	$0x300000001, %r11      # imm = 0x300000001
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movl	$0x1, -0x30(%rbp)
               	movl	$0x2, -0x2c(%rbp)
               	movl	$0x3, -0x28(%rbp)
               	movl	$0x4, -0x24(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	$0x0, (%rax)
               	movl	$0x2, -0x20(%rbp)
               	movl	$0x4, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x400000002, %r11      # imm = 0x400000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movb	$0x64, -0x40(%rbp)
               	movb	$0x64, -0x3f(%rbp)
               	movb	$0x64, -0x3e(%rbp)
               	movb	$0x64, -0x3d(%rbp)
               	movb	$0x64, -0x3c(%rbp)
               	movb	$0x64, -0x3b(%rbp)
               	movb	$0x64, -0x3a(%rbp)
               	movb	$0x64, -0x39(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movb	$0x64, -0x38(%rbp)
               	movb	$0x64, -0x37(%rbp)
               	movb	$0x64, -0x36(%rbp)
               	movb	$0x64, -0x35(%rbp)
               	movb	$0x64, -0x34(%rbp)
               	movb	$0x64, -0x33(%rbp)
               	movb	$0x64, -0x32(%rbp)
               	movb	$0x64, -0x31(%rbp)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	paddb	%xmm1, %xmm0
               	movsd	%xmm0, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movabsq	$-0x3737373737373738, %r11 # imm = 0xC8C8C8C8C8C8C8C8
               	cmpq	%r11, %rax
               	jne	<addr>
               	movb	$0x7f, -0x8(%rbp)
               	movb	$0x7f, -0x7(%rbp)
               	movb	$0x7f, -0x6(%rbp)
               	movb	$0x7f, -0x5(%rbp)
               	movb	$0x7f, -0x4(%rbp)
               	movb	$0x7f, -0x3(%rbp)
               	movb	$0x7f, -0x2(%rbp)
               	movb	$0x7f, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x7f7f7f7f7f7f7f7f, %r11 # imm = 0x7F7F7F7F7F7F7F7F
               	cmpq	%r11, %rax
               	jne	<addr>
               	movb	$-0x1, -0x8(%rbp)
               	movb	$-0x1, -0x7(%rbp)
               	movb	$-0x1, -0x6(%rbp)
               	movb	$-0x1, -0x5(%rbp)
               	movb	$-0x1, -0x4(%rbp)
               	movb	$-0x1, -0x3(%rbp)
               	movb	$-0x1, -0x2(%rbp)
               	movb	$-0x1, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movw	$0x0, -0x8(%rbp)
               	movw	$0x0, -0x6(%rbp)
               	movw	$0x0, -0x4(%rbp)
               	movw	$0x0, -0x2(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movw	$0x8000, -0x8(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x6(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x4(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x2(%rbp)     # imm = 0x8000
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x7fff7fff7fff8000, %r11 # imm = 0x8000800080008000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movw	$0xffff, -0x8(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0x6(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0x4(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0x2(%rbp)     # imm = 0xFFFF
               	movq	-0x8(%rbp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movb	$-0x80, -0x8(%rbp)
               	movb	$-0x80, -0x7(%rbp)
               	movb	$-0x80, -0x6(%rbp)
               	movb	$-0x80, -0x5(%rbp)
               	movb	$-0x80, -0x4(%rbp)
               	movb	$-0x80, -0x3(%rbp)
               	movb	$-0x80, -0x2(%rbp)
               	movb	$-0x80, -0x1(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x7f7f7f7f7f7f7f80, %r11 # imm = 0x8080808080808080
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movw	$0x1, -0x30(%rbp)
               	movw	$0x2, -0x2e(%rbp)
               	movw	$0x3, -0x2c(%rbp)
               	movw	$0x4, -0x2a(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movw	$0x5, -0x28(%rbp)
               	movw	$0x6, -0x26(%rbp)
               	movw	$0x7, -0x24(%rbp)
               	movw	$0x8, -0x22(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movswq	-0x20(%rbp), %rax
               	movswq	-0x18(%rbp), %rcx
               	imulq	%rcx, %rax
               	movswq	-0x1e(%rbp), %rcx
               	movswq	-0x16(%rbp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movswq	-0x1c(%rbp), %rcx
               	movswq	-0x14(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movswq	-0x1a(%rbp), %rdx
               	movswq	-0x12(%rbp), %rsi
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	$0x0, (%rdx)
               	movl	%eax, -0x8(%rbp)
               	movl	%ecx, -0x4(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3500000011, %r11     # imm = 0x3500000011
               	cmpq	%r11, %rax
               	jne	<addr>
               	movw	$0x8000, -0x30(%rbp)    # imm = 0x8000
               	movw	$0x8000, -0x2e(%rbp)    # imm = 0x8000
               	movw	$0x8000, -0x2c(%rbp)    # imm = 0x8000
               	movw	$0x8000, -0x2a(%rbp)    # imm = 0x8000
               	leaq	-0x28(%rbp), %rcx
               	movw	$0x8000, -0x28(%rbp)    # imm = 0x8000
               	movw	$0x8000, -0x26(%rbp)    # imm = 0x8000
               	movw	$0x8000, -0x24(%rbp)    # imm = 0x8000
               	movw	$0x8000, -0x22(%rbp)    # imm = 0x8000
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movswq	-0x20(%rbp), %rax
               	movswq	-0x18(%rbp), %rcx
               	imulq	%rcx, %rax
               	movswq	-0x1e(%rbp), %rcx
               	movswq	-0x16(%rbp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movswq	-0x1c(%rbp), %rcx
               	movswq	-0x14(%rbp), %rdx
               	imulq	%rdx, %rcx
               	leaq	-0x20(%rbp), %rdx
               	movswq	-0x1a(%rbp), %rsi
               	movswq	-0x12(%rbp), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	leaq	-0x8(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	movl	%eax, -0x8(%rbp)
               	movl	%ecx, -0x4(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x7fffffff80000000, %r11 # imm = 0x8000000080000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rsi
               	movw	$0xfffe, -0x30(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x2e(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x2c(%rbp)    # imm = 0xFFFE
               	movw	$0xfffe, -0x2a(%rbp)    # imm = 0xFFFE
               	leaq	-0x28(%rbp), %rcx
               	movw	$0x4000, -0x28(%rbp)    # imm = 0x4000
               	movw	$0x4000, -0x26(%rbp)    # imm = 0x4000
               	movw	$0x4000, -0x24(%rbp)    # imm = 0x4000
               	movw	$0x4000, -0x22(%rbp)    # imm = 0x4000
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movswq	-0x20(%rbp), %rax
               	movswq	-0x18(%rbp), %rcx
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	movw	%ax, -0x10(%rbp)
               	movswq	-0x1e(%rbp), %rax
               	movswq	-0x16(%rbp), %rcx
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	movw	%ax, -0xe(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movswq	-0x1c(%rbp), %rax
               	leaq	-0x18(%rbp), %rdx
               	movswq	-0x14(%rbp), %rsi
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	movw	%ax, -0xc(%rbp)
               	movswq	-0x1a(%rbp), %rax
               	movswq	-0x12(%rbp), %rsi
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	movw	%ax, -0xa(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movw	$0x12c, -0x30(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x2e(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x2c(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x2a(%rbp)     # imm = 0x12C
               	leaq	-0x28(%rbp), %rdi
               	movw	$0x12c, -0x28(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x26(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x24(%rbp)     # imm = 0x12C
               	movw	$0x12c, -0x22(%rbp)     # imm = 0x12C
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movq	(%rdi), %r10
               	movq	%r10, (%rdx)
               	movzwq	-0x20(%rbp), %rax
               	movzwq	-0x18(%rbp), %rcx
               	imulq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x10(%rbp)
               	movzwq	-0x1e(%rbp), %rax
               	movzwq	-0x16(%rbp), %rcx
               	imulq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0xe(%rbp)
               	movzwq	-0x1c(%rbp), %rax
               	movzwq	-0x14(%rbp), %rcx
               	imulq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0xc(%rbp)
               	movzwq	-0x1a(%rbp), %rax
               	movzwq	-0x12(%rbp), %rcx
               	imulq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0xa(%rbp)
               	movq	-0x10(%rbp), %rax
               	movabsq	$0x5f905f905f905f90, %r11 # imm = 0x5F905F905F905F90
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movw	$0x8000, -0x8(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x6(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x4(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x2(%rbp)     # imm = 0x8000
               	movq	-0x8(%rbp), %rcx
               	movabsq	$-0x7fff7fff7fff8000, %r11 # imm = 0x8000800080008000
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	$0x0, -0x8(%rbp)
               	movw	$0x8000, -0x8(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x6(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x4(%rbp)     # imm = 0x8000
               	movw	$0x8000, -0x2(%rbp)     # imm = 0x8000
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movq	$0x14, -0x28(%rbp)
               	movw	$0xffff, -0x10(%rbp)    # imm = 0xFFFF
               	movw	$0xffff, -0xe(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0xc(%rbp)     # imm = 0xFFFF
               	movw	$0xffff, -0xa(%rbp)     # imm = 0xFFFF
               	movq	-0x10(%rbp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x4(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movabsq	$0xf0000000f, %r11      # imm = 0xF0000000F
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movq	$0x0, -0x8(%rbp)
               	movabsq	$0xfffffffffffffff, %rcx # imm = 0xFFFFFFFFFFFFFFF
               	movq	%rcx, -0x8(%rbp)
               	movl	$0xfffffff8, -0x30(%rbp) # imm = 0xFFFFFFF8
               	movl	$0xfffffff8, -0x2c(%rbp) # imm = 0xFFFFFFF8
               	movq	$0x1, -0x28(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movl	$0xfffffffc, -0x10(%rbp) # imm = 0xFFFFFFFC
               	movl	$0xfffffffc, -0xc(%rbp) # imm = 0xFFFFFFFC
               	movq	-0x10(%rbp), %rcx
               	movabsq	$-0x300000004, %r11     # imm = 0xFFFFFFFCFFFFFFFC
               	cmpq	%r11, %rcx
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0xf0f0f0f0f0f0f10, %rax # imm = 0xF0F0F0F0F0F0F0F0
               	movq	%rax, -0x10(%rbp)
               	movabsq	$-0xff00ff00ff0100, %rax # imm = 0xFF00FF00FF00FF00
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	-0x30(%rbp), %ecx
               	xorq	$-0x1, %rcx
               	movl	%ecx, -0x20(%rbp)
               	movl	-0x2c(%rbp), %ecx
               	xorq	$-0x1, %rcx
               	movl	%ecx, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rcx
               	andq	%rcx, %rax
               	movq	%rax, -0x18(%rbp)
               	movabsq	$0xf000f000f000f00, %r11 # imm = 0xF000F000F000F00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movw	$0x1, -0x30(%rbp)
               	movw	$0x2, -0x2e(%rbp)
               	movw	$0x3, -0x2c(%rbp)
               	movw	$0x4, -0x2a(%rbp)
               	movw	$0x1, -0x28(%rbp)
               	movw	$0x0, -0x26(%rbp)
               	movw	$0x3, -0x24(%rbp)
               	movw	$0x0, -0x22(%rbp)
               	movw	$0xffff, -0x20(%rbp)    # imm = 0xFFFF
               	movw	$0x0, -0x1e(%rbp)
               	movw	$0xffff, -0x1c(%rbp)    # imm = 0xFFFF
               	movw	$0x0, -0x1a(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movabsq	$0xffff0000ffff, %r11   # imm = 0xFFFF0000FFFF
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movl	$0x5, -0x30(%rbp)
               	movl	$0xffffffff, -0x2c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x4, -0x28(%rbp)
               	movl	$0x0, -0x24(%rbp)
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	$0x0, -0x1c(%rbp)
               	movq	-0x20(%rbp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movb	$-0x1, -0x8(%rbp)
               	movb	$-0x1, -0x7(%rbp)
               	movb	$-0x1, -0x6(%rbp)
               	movb	$-0x1, -0x5(%rbp)
               	movb	$-0x1, -0x4(%rbp)
               	movb	$-0x1, -0x3(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movb	$-0x1, -0x2(%rbp)
               	movb	$-0x1, -0x1(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movq	$0x0, -0x28(%rbp)
               	movb	$0x0, -0x20(%rbp)
               	movb	$0x0, -0x1f(%rbp)
               	movb	$0x0, -0x1e(%rbp)
               	movb	$0x0, -0x1d(%rbp)
               	movb	$0x0, -0x1c(%rbp)
               	movb	$0x0, -0x1b(%rbp)
               	movb	$0x0, -0x1a(%rbp)
               	movb	$0x0, -0x19(%rbp)
               	cmpq	$0x0, -0x20(%rbp)
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movw	$0x1, -0x10(%rbp)
               	movw	$0x2, -0xe(%rbp)
               	movw	$0x3, -0xc(%rbp)
               	movw	$0x4, -0xa(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movw	$0x1, -0x8(%rbp)
               	movw	$0x1, -0x6(%rbp)
               	movw	$0x1, -0x4(%rbp)
               	movw	$0x1, -0x2(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	paddw	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x5000400030002, %r11  # imm = 0x5000400030002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	emms
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x10, %eax
               	leave
               	retq

<sse3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rdx
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x2c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movss	-0x28(%rbp), %xmm0
               	movss	-0x24(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x4c(%rbp)
               	movss	-0x40(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movss	-0x38(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x5c(%rbp), %xmm0
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x58(%rbp), %xmm0
               	movl	$0x41300000, %eax       # imm = 0x41300000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x54(%rbp), %xmm0
               	movl	$0x41700000, %eax       # imm = 0x41700000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x2c(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movss	-0x28(%rbp), %xmm0
               	movss	-0x24(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x4c(%rbp)
               	movss	-0x40(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movss	-0x38(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movl	$0xbf800000, %eax       # imm = 0xBF800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x5c(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x58(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x54(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x30(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movss	-0x2c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x4c(%rbp)
               	movss	-0x28(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movss	-0x24(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x5c(%rbp), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x58(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x54(%rbp), %xmm0
               	movl	$0x40900000, %eax       # imm = 0x40900000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x3c(%rbp), %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movss	%xmm0, -0x4c(%rbp)
               	movss	-0x34(%rbp), %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movss	%xmm0, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x90(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movss	-0x40(%rbp), %xmm0
               	movss	%xmm0, -0x50(%rbp)
               	movss	%xmm0, -0x4c(%rbp)
               	movss	-0x38(%rbp), %xmm0
               	movss	%xmm0, -0x48(%rbp)
               	movss	%xmm0, -0x44(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x54(%rbp), %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x4c(%rbp), %xmm0
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movss	-0x48(%rbp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x50(%rbp)
               	movsd	-0x28(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x48(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x58(%rbp), %xmm0
               	movabsq	$0x4006000000000000, %rax # imm = 0x4006000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x50(%rbp)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x48(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x30(%rbp), %xmm0
               	movsd	-0x28(%rbp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x50(%rbp)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x48(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x58(%rbp), %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movabsq	$-0x4010000000000000, %rax # imm = 0xBFF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x28(%rbp), %xmm0
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movabsq	$0x4019000000000000, %rax # imm = 0x4019000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x60(%rbp)
               	movsd	%xmm0, -0x58(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movsd	-0x40(%rbp), %xmm0
               	movsd	%xmm0, -0x50(%rbp)
               	movsd	%xmm0, -0x48(%rbp)
               	movups	-0x50(%rbp), %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movabsq	$0x4019000000000000, %rax # imm = 0x4019000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x58(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x28(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x11, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	movups	0x1(%rax), %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x4030201, %eax        # imm = 0x4030201
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %ecx
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	movl	$0xffffffbf, %r11d      # imm = 0xFFFFFFBF
               	andq	%r11, %rax
               	orq	$0x40, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	andq	$0x40, %rax
               	movq	%rax, %rdx
               	xorq	$0x40, %rdx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	ldmxcsr	(%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	stmxcsr	(%rax)
               	movl	-0x8(%rbp), %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<wait_on>:
               	movq	%rdi, %rax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	monitor
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	mwait
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x64, %edx
               	movl	$0x40, %esi
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testb	$0x3f, %cl
               	jne	<addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x64, %eax
               	jl	<addr>
               	movq	%rcx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, %edx
               	movl	$0x8, %esi
               	leaq	-0x8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	testb	$0x7, %al
               	jne	<addr>
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
