
avx2_lanes_and_low_lane_transfers_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_moves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movups	(%rbx), %xmm1
               	movups	0x10(%rbx), %xmm2
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpextrb	$0x0, %xmm1, %eax
               	movsbq	%al, %rax
               	movsbq	%al, %rax
               	andq	$0xff, %rax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	movq	%rdx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm3
               	vpinsrb	$0x0, %eax, %xmm3, %xmm3
               	vpinsrb	$0x1, %eax, %xmm3, %xmm3
               	vpinsrb	$0x2, %eax, %xmm3, %xmm3
               	vpinsrb	$0x3, %eax, %xmm3, %xmm3
               	vpinsrb	$0x4, %eax, %xmm3, %xmm3
               	vpinsrb	$0x5, %eax, %xmm3, %xmm3
               	vpinsrb	$0x6, %eax, %xmm3, %xmm3
               	vpinsrb	$0x7, %eax, %xmm3, %xmm3
               	vpinsrb	$0x8, %eax, %xmm3, %xmm3
               	vpinsrb	$0x9, %eax, %xmm3, %xmm3
               	vpinsrb	$0xa, %eax, %xmm3, %xmm3
               	vpinsrb	$0xb, %eax, %xmm3, %xmm3
               	vpinsrb	$0xc, %eax, %xmm3, %xmm3
               	vpinsrb	$0xd, %eax, %xmm3, %xmm3
               	vpinsrb	$0xe, %eax, %xmm3, %xmm3
               	vpinsrb	$0xf, %eax, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm0, %ymm0
               	vmovups	%ymm0, (%rsp)
               	vpextrw	$0x0, %xmm1, %eax
               	movswq	%ax, %rax
               	movswq	%ax, %rax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	movq	%rdx, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %eax, %xmm0, %xmm0
               	vpinsrw	$0x2, %eax, %xmm0, %xmm0
               	vpinsrw	$0x3, %eax, %xmm0, %xmm0
               	vpinsrw	$0x4, %eax, %xmm0, %xmm0
               	vpinsrw	$0x5, %eax, %xmm0, %xmm0
               	vpinsrw	$0x6, %eax, %xmm0, %xmm0
               	vpinsrw	$0x7, %eax, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm3
               	vpinsrw	$0x0, %eax, %xmm3, %xmm3
               	vpinsrw	$0x1, %eax, %xmm3, %xmm3
               	vpinsrw	$0x2, %eax, %xmm3, %xmm3
               	vpinsrw	$0x3, %eax, %xmm3, %xmm3
               	vpinsrw	$0x4, %eax, %xmm3, %xmm3
               	vpinsrw	$0x5, %eax, %xmm3, %xmm3
               	vpinsrw	$0x6, %eax, %xmm3, %xmm3
               	vpinsrw	$0x7, %eax, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rsp)
               	vmovd	%xmm1, %eax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	vmovd	%eax, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movapd	%xmm0, %xmm14
               	vpinsrd	$0x3, %eax, %xmm14, %xmm14
               	movups	%xmm14, -0x30(%rbp)
               	movups	-0x30(%rbp), %xmm15
               	vmovdqa	%xmm15, %xmm0
               	xorl	%ecx, %ecx
               	vmovd	%eax, %xmm3
               	vpinsrd	$0x1, %eax, %xmm3, %xmm3
               	vpinsrd	$0x2, %eax, %xmm3, %xmm3
               	movapd	%xmm3, %xmm14
               	vpinsrd	$0x3, %eax, %xmm14, %xmm14
               	movups	%xmm14, -0x40(%rbp)
               	movups	-0x40(%rbp), %xmm15
               	vinserti128	$0x1, %xmm15, %ymm0, %ymm14
               	vmovups	%ymm14, -0x60(%rbp)
               	vmovups	-0x60(%rbp), %ymm14
               	vmovups	%ymm14, 0x40(%rsp)
               	vmovq	%xmm1, %rax
               	xorl	%r12d, %r12d
               	vmovq	%rax, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	vmovq	%rax, %xmm3
               	vpinsrq	$0x1, %rax, %xmm3, %xmm3
               	vinserti128	$0x1, %xmm3, %ymm0, %ymm0
               	vmovups	%ymm0, 0x60(%rsp)
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	leaq	(%rsp), %rdx
               	movq	%r12, %rsi
               	shlq	$0x5, %rsi
               	addq	%rsi, %rdx
               	vmovups	(%rdx), %ymm0
               	vmovups	%ymm0, (%rax)
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	leaq	-0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rsi,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	imulq	$0x0, %rcx, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shlxq	%r9, %rdi, %rdi
               	orq	%rdi, %rsi
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x4, %r12d
               	jl	<addr>
               	vmovdqa	%xmm1, %xmm0
               	vinserti128	$0x1, %xmm2, %ymm0, %ymm14
               	vmovups	%ymm14, -0x80(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	vmovups	-0x80(%rbp), %ymm14
               	vmovups	%ymm14, (%rdi)
               	movl	$0x20, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	vmovups	-0x80(%rbp), %ymm0
               	vmovdqa	%xmm0, %xmm1
               	movups	%xmm1, (%rsp)
               	vextracti128	$0x1, %ymm0, %xmm0
               	movups	%xmm0, 0x10(%rsp)
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movl	$0x10, %edx
               	leaq	0x10(%rax), %rdi
               	leaq	0x10(%rbx), %rsi
               	xorl	%eax, %eax
               	vzeroupper
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	xorl	%eax, %eax
               	vmovq	%rax, %xmm14
               	vmovups	%ymm14, (%rcx)
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movq	$-0x2, %rax
               	movups	-0x30(%rbp), %xmm0
               	vpinsrd	$0x0, %eax, %xmm0, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	vmovups	-0x60(%rbp), %ymm14
               	vinserti128	$0x0, %xmm0, %ymm14, %ymm0
               	movups	-0x40(%rbp), %xmm1
               	vpinsrd	$0x0, %eax, %xmm1, %xmm1
               	vpinsrd	$0x1, %eax, %xmm1, %xmm1
               	vpinsrd	$0x2, %eax, %xmm1, %xmm1
               	vpinsrd	$0x3, %eax, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	vmovups	%ymm0, (%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1c(%rax), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rcx
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%rdx,%rax), %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	vzeroupper
               	leave
               	retq

<check_low_lane>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	leaq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x1(%r13), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	movq	-0x8(%rbp), %rdx
               	vmovq	%rdx, %xmm0
               	vpinsrq	$0x1, %rax, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	0x3(%r13), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movslq	-0x8(%rbp), %rcx
               	vmovd	%ecx, %xmm0
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	leaq	0x5(%r13), %rax
               	leaq	-0x8(%rbp), %rcx
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	xorl	%r12d, %r12d
               	movswq	-0x8(%rbp), %rax
               	movq	%r12, %xmm0
               	vpinsrw	$0x0, %eax, %xmm0, %xmm0
               	vpinsrw	$0x1, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x2, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x3, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x4, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x5, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x6, %r12d, %xmm0, %xmm0
               	vpinsrw	$0x7, %r12d, %xmm0, %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	movl	$0x8, %eax
               	sarxq	%r12, %rax, %rbx
               	leaq	-0x18(%rbp), %rdi
               	leaq	-0x50(%rbp), %rax
               	movq	%r12, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movups	(%rax), %xmm0
               	movups	%xmm0, (%rdi)
               	leaq	0x1(%r13), %rax
               	movq	%r12, %rcx
               	shlq	%rcx
               	leaq	(%rax,%rcx), %rsi
               	movslq	%ebx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x10, %ebx
               	jge	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ebx, %rcx
               	cmpb	$0x0, (%rax,%rcx)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x10, %ebx
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movb	$-0x56, -0x18(%rbp)
               	movb	$-0x56, -0x17(%rbp)
               	movb	$-0x56, -0x16(%rbp)
               	movb	$-0x56, -0x15(%rbp)
               	movb	$-0x56, -0x14(%rbp)
               	movb	$-0x56, -0x13(%rbp)
               	movb	$-0x56, -0x12(%rbp)
               	movb	$-0x56, -0x11(%rbp)
               	movb	$-0x56, -0x10(%rbp)
               	movb	$-0x56, -0xf(%rbp)
               	movb	$-0x56, -0xe(%rbp)
               	movb	$-0x56, -0xd(%rbp)
               	movb	$-0x56, -0xc(%rbp)
               	movb	$-0x56, -0xb(%rbp)
               	movb	$-0x56, -0xa(%rbp)
               	movb	$-0x56, -0x9(%rbp)
               	movb	$-0x56, -0x8(%rbp)
               	movb	$-0x56, -0x7(%rbp)
               	movb	$-0x56, -0x6(%rbp)
               	movb	$-0x56, -0x5(%rbp)
               	movb	$-0x56, -0x4(%rbp)
               	movb	$-0x56, -0x3(%rbp)
               	movb	$-0x56, -0x2(%rbp)
               	movb	$-0x56, -0x1(%rbp)
               	leaq	0x1(%rcx), %rdx
               	movq	-0x50(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	0xb(%rcx), %rdx
               	movl	-0x40(%rbp), %esi
               	movl	%esi, -0x20(%rbp)
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdx)
               	leaq	0x11(%rcx), %rax
               	movzwq	-0x30(%rbp), %rcx
               	movswq	%cx, %rcx
               	movw	%cx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	leaq	0x1(%r13), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x18(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0xf(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0xb(%rax), %rdi
               	leaq	0x3(%r13), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x9(%rbp), %rcx
               	cmpl	$0xaa, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	0x11(%rax), %rdi
               	leaq	0x5(%r13), %rsi
               	movl	$0x2, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	-0x5(%rbp), %rax
               	cmpl	$0xaa, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<find16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	%esi, -0x10(%rbp)
               	xorl	%eax, %eax
               	movl	%eax, -0xc(%rbp)
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x4(%rbp)
               	movzwq	-0x10(%rbp), %rcx
               	movswq	%cx, %rcx
               	xorl	%edx, %edx
               	xorl	%r8d, %r8d
               	movq	%r8, %xmm0
               	vpinsrw	$0x0, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x1, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x2, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x3, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x4, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x5, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x6, %ecx, %xmm0, %xmm0
               	vpinsrw	$0x7, %ecx, %xmm0, %xmm0
               	vmovdqa	%xmm0, %xmm0
               	xorl	%edx, %edx
               	movq	%rdx, %xmm1
               	vpinsrw	$0x0, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x1, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x2, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x3, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x4, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x5, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x6, %ecx, %xmm1, %xmm1
               	vpinsrw	$0x7, %ecx, %xmm1, %xmm1
               	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
               	leaq	0x10(%rax), %rcx
               	movq	%rax, %rdx
               	shlq	%rdx
               	addq	%rdi, %rdx
               	vmovups	(%rdx), %ymm1
               	vpcmpeqw	%ymm0, %ymm1, %ymm1
               	vpmovmskb	%ymm1, %edx
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rcx, %rax
               	leaq	0x10(%rax), %rcx
               	cmpl	$0x28, %ecx
               	jbe	<addr>
               	cmpl	$0x28, %eax
               	jae	<addr>
               	movzwq	(%rdi,%rax,2), %rcx
               	cmpl	%esi, %ecx
               	je	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jb	<addr>
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq
               	shlq	%rax
               	addq	%rdi, %rax
               	vzeroupper
               	leave
               	retq
               	shlq	%rax
               	addq	%rdi, %rax
               	movl	$0x20, %r11d
               	bsfl	%edx, %ecx
               	cmovel	%r11d, %ecx
               	sarq	%rcx
               	shlq	%rcx
               	addq	%rcx, %rax
               	vzeroupper
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x200, %rsp            # imm = 0x200
               	andq	$-0x20, %rsp
               	xorl	%r15d, %r15d
               	leaq	-0xb0(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	testb	$0x1, %r15b
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0xb0(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0xb0(%rbp), %r8
               	leaq	-0x90(%rbp), %r9
               	vmovups	(%r8), %ymm0
               	vmovups	(%r9), %ymm1
               	leaq	(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movups	%xmm14, 0x100(%rax)
               	movups	%xmm14, 0x110(%rax)
               	movups	%xmm14, 0x120(%rax)
               	movups	%xmm14, 0x130(%rax)
               	movups	%xmm14, 0x140(%rax)
               	movups	%xmm14, 0x150(%rax)
               	movups	%xmm14, 0x160(%rax)
               	movups	%xmm14, 0x170(%rax)
               	vpaddb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rsp)
               	vpaddw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x20(%rsp)
               	vpaddd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x40(%rsp)
               	vpaddq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x60(%rsp)
               	vpsubb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x80(%rsp)
               	vpsubw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xa0(%rsp)
               	vpsubd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xc0(%rsp)
               	vpsubq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0xe0(%rsp)
               	vpcmpeqb	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x100(%rsp)
               	vpcmpeqw	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x120(%rsp)
               	vpcmpeqd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x140(%rsp)
               	vpcmpeqq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x160(%rsp)
               	xorl	%r14d, %r14d
               	movl	$0x1, %eax
               	movq	%r14, %rcx
               	andq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rcx
               	leaq	-0x70(%rbp), %rax
               	leaq	(%rsp), %rdx
               	movq	%r14, %rsi
               	shlq	$0x5, %rsi
               	addq	%rsi, %rdx
               	vmovups	(%rdx), %ymm2
               	vmovups	%ymm2, (%rax)
               	xorl	%esi, %esi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %esi
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r8,%rdi), %rdi
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	shlxq	%rbx, %rdi, %rdi
               	orq	%rdi, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdi
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rbx
               	imulq	%rsi, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%r9,%rbx), %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shlxq	%r12, %rbx, %rbx
               	orq	%rbx, %rdi
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x4, %r14d
               	jge	<addr>
               	leaq	(%rdx,%rdi), %r13
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rbx
               	imulq	%rsi, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rdi,%rbx), %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shlxq	%r12, %rbx, %rbx
               	orq	%rbx, %rdx
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	$-0x1, %rax
               	andq	%r13, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rax, %rax
               	decq	%rax
               	jmp	<addr>
               	cmpl	$0x8, %r14d
               	jge	<addr>
               	movq	%rdx, %r13
               	subq	%rdi, %r13
               	jmp	<addr>
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	movq	$-0x1, %r13
               	jmp	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	incq	%rsi
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %esi
               	jl	<addr>
               	incq	%r14
               	cmpl	$0xc, %r14d
               	jl	<addr>
               	leaq	0x180(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	vpand	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x180(%rsp)
               	vpandn	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x1a0(%rsp)
               	vpor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x1c0(%rsp)
               	vpxor	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, 0x1e0(%rsp)
               	xorl	%edx, %edx
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x180(%rsp), %rax
               	movq	%rdx, %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	vmovups	(%rax), %ymm2
               	vmovups	%ymm2, (%rsi)
               	xorl	%eax, %eax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	(%r8,%rax), %rcx
               	movzbq	(%r9,%rax), %rdi
               	andq	%rdi, %rcx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%ecx, %edi
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movzbq	(%r8,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movzbq	(%r9,%rax), %rdi
               	andq	%rdi, %rcx
               	jmp	<addr>
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movzbq	(%r8,%rax), %rcx
               	movzbq	(%r9,%rax), %rdi
               	orq	%rdi, %rcx
               	jmp	<addr>
               	movzbq	(%r8,%rax), %rcx
               	movzbq	(%r9,%rax), %rdi
               	xorq	%rdi, %rcx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%r8,%rax), %rdx
               	shrq	$0x7, %rdx
               	shlxq	%rax, %rdx, %rdx
               	orq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vpmovmskb	%ymm0, %eax
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%eax, %eax
               	movzbq	(%r8,%rax), %rdx
               	movzbq	(%r9,%rax), %rsi
               	andq	%rsi, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vpand	%ymm1, %ymm0, %ymm0
               	vmovq	%xmm0, %rax
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm1
               	vmovq	%xmm1, %rdx
               	orq	%rdx, %rax
               	vextracti128	$0x1, %ymm0, %xmm0
               	vpextrq	$0x1, %xmm0, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	vzeroupper
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%r15
               	cmpl	$0xc8, %r15d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rcx
               	leaq	0x100(%rax), %rdx
               	movw	%dx, (%rcx,%rax,2)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x115, %esi            # imm = 0x115
               	movl	$0x28, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x2a(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xaf, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x127, %esi            # imm = 0x127
               	movl	$0x28, %edx
               	vzeroupper
               	callq	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	0x4e(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb0, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x21, %esi
               	movl	$0x28, %edx
               	vzeroupper
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb1, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xaa, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xa9, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xa8, %eax
               	leaq	-0xe0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
