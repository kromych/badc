
sse41_integer_lanes_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_products_packs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x50(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0xc(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	imulq	%rdx, %rcx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rcx, %r8
               	shlq	%r8
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rdi,%rbx), %rbx
               	orq	%rbx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rdx
               	movq	%rcx, %rbx
               	shlq	%rbx
               	xorl	%r8d, %r8d
               	movl	$0x3, %eax
               	shlq	$0x8, %r8
               	movq	%rbx, %r12
               	shlq	$0x2, %r12
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r8, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %r8
               	imulq	%rdx, %r8
               	xorl	%eax, %eax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %r8, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r9,%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r9
               	xorl	%edx, %edx
               	movl	$0x7, %eax
               	shlq	$0x8, %rdx
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x7, %eax
               	shlq	$0x8, %r8
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%r8, %rdx
               	jle	<addr>
               	movq	$-0x1, %rdx
               	xorl	%eax, %eax
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %rdx, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r9,%r8)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%edx, %edx
               	cmpl	$0x4, %edx
               	jge	<addr>
               	movq	%rdi, %r8
               	movq	%rdx, %r9
               	andq	$0x3, %r9
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movq	%r9, %rbx
               	shlq	$0x2, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%r8,%rbx), %rbx
               	orq	%rbx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	leaq	-0x30(%rbp), %r8
               	testq	%rcx, %rcx
               	jge	<addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	movq	%rdx, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %rcx, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r8,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	cmpq	$0xffff, %rcx           # imm = 0xFFFF
               	jle	<addr>
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	jmp	<addr>
               	movq	%rsi, %r8
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x90(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmulld	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmuldq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x70(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	packusdw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	leaq	-0x60(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpgtq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<check_extensions>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1c0, %rsp            # imm = 0x1C0
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x1b0(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1c0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1b0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	movups	%xmm14, 0x80(%rcx)
               	movups	%xmm14, 0x90(%rcx)
               	movups	%xmm14, 0xa0(%rcx)
               	movups	%xmm14, 0xb0(%rcx)
               	leaq	-0xf0(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pmovsxbw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xe0(%rbp), %rdx
               	movdqu	(%rax), %xmm14
               	pmovsxbd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	addq	$0x10, %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pmovsxbq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x1b0(%rbp), %rax
               	leaq	0x20(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x1c0(%rbp), %rcx
               	leaq	-0xc0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovsxwd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	0x30(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0xb0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovsxwq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	addq	$0x40, %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovsxdq	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x1b0(%rbp), %rax
               	leaq	0x50(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1c0(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovzxbw	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero,xmm14[2],zero,xmm14[3],zero,xmm14[4],zero,xmm14[5],zero,xmm14[6],zero,xmm14[7],zero
               	movdqu	%xmm15, (%rdx)
               	leaq	0x60(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovzxbd	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,xmm14[1],zero,zero,zero,xmm14[2],zero,zero,zero,xmm14[3],zero,zero,zero
               	movdqu	%xmm15, (%rdx)
               	addq	$0x70, %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovzxbq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,zero,zero,zero,zero,xmm14[1],zero,zero,zero,zero,zero,zero,zero
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x1b0(%rbp), %rax
               	leaq	0x80(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1c0(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovzxwd	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero,xmm14[2],zero,xmm14[3],zero
               	movdqu	%xmm15, (%rdx)
               	leaq	0x90(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x50(%rbp), %rdx
               	movdqu	(%rcx), %xmm14
               	pmovzxwq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,zero,zero,xmm14[1],zero,zero,zero
               	movdqu	%xmm15, (%rdx)
               	addq	$0xa0, %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movdqu	(%rcx), %xmm14
               	pmovzxdq	%xmm14, %xmm15          # xmm15 = xmm14[0],zero,xmm14[1],zero
               	movdqu	%xmm15, (%rax)
               	leaq	-0x1b0(%rbp), %rcx
               	addq	$0xb0, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%r14d, %r14d
               	leaq	<rip>, %rax # <addr>
               	imulq	$0x2aaaaaab, %r14, %rcx # imm = 0x2AAAAAAB
               	shrq	$0x20, %rcx
               	imulq	$0x6, %rcx, %rcx
               	movq	%r14, %rdx
               	subq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	xorl	%esi, %esi
               	movl	(%rax), %r9d
               	movl	0x4(%rax), %r8d
               	cmpl	$0x6, %r14d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %esi
               	jge	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	leaq	-0x1(%r9), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%r9, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %r9d
               	jge	<addr>
               	movq	%r9, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%r9, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	%r8, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rdi)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	incq	%rsi
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %esi
               	jl	<addr>
               	leaq	-0x1b0(%rbp), %rax
               	movq	%r14, %rcx
               	shlq	$0x4, %rcx
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r14
               	cmpl	$0xc, %r14d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<check_blends>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	xorl	%r8d, %r8d
               	leaq	-0x20(%rbp), %r9
               	xorl	%eax, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	leaq	-0x160(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x150(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x140(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0x0, %xmm14, %xmm15    # xmm15 = xmm15[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r13d
               	xorl	%r8d, %r8d
               	leaq	-0x20(%rbp), %r9
               	movl	$0xff, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	leaq	-0x130(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x110(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0xff, %xmm14, %xmm15   # xmm15 = xmm14[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r13d
               	xorl	%r8d, %r8d
               	leaq	-0x20(%rbp), %r9
               	movl	$0xa5, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	leaq	-0x100(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xf0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xe0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0xa5, %xmm14, %xmm15   # xmm15 = xmm14[0],xmm15[1],xmm14[2],xmm15[3,4],xmm14[5],xmm15[6],xmm14[7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r13d
               	xorl	%r8d, %r8d
               	leaq	-0x20(%rbp), %r9
               	movl	$0x3c, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xb0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0x3c, %xmm14, %xmm15   # xmm15 = xmm15[0,1],xmm14[2,3,4,5],xmm15[6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r13d
               	xorl	%r8d, %r8d
               	leaq	-0x20(%rbp), %r9
               	movl	$0x81, %eax
               	sarxq	%r8, %rax, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	%r12, %rsi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%r8, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rbx, %rsi
               	jmp	<addr>
               	incq	%r8
               	cmpl	$0x8, %r8d
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pblendw	$0x81, %xmm14, %xmm15   # xmm15 = xmm14[0],xmm15[1,2,3,4,5,6],xmm14[7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r13d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movzbq	(%r14,%rax), %rcx
               	testb	$-0x80, %cl
               	je	<addr>
               	movzbq	(%r12,%rax), %rcx
               	jmp	<addr>
               	movzbq	(%rbx,%rax), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x50(%rbp), %rdx
               	movups	(%r14), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x30(%rbp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x70(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x70(%rbp), %rsi
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rsi)
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rdi
               	testb	$-0x80, %dil
               	je	<addr>
               	movsbq	(%rdx,%rax), %rdi
               	movb	%dil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x50(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rax
               	movups	%xmm0, -0x40(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %r13d
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%r13d, %r13d
               	jmp	<addr>

<check_elements>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rsi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	movslq	%ecx, %r13
               	xorl	%r12d, %r12d
               	movl	$0x7, %eax
               	shlq	$0x8, %r12
               	leaq	0x8(%rax), %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	orq	%rcx, %r12
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%r14d, %r14d
               	leaq	-0x120(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrb	$0x0, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x30(%rbp), %eax
               	movzbq	(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x110(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x28(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrb	$0x9, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x28(%rbp), %eax
               	movzbq	0x9(%rbx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	-0x100(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrb	$0xf, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x20(%rbp), %eax
               	movzbq	0xf(%rbx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x10, %r14d
               	leaq	-0xf0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrd	$0x3, %xmm14, %r11d
               	movl	%r11d, (%rcx)
               	movl	-0x18(%rbp), %esi
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrq	$0x0, %xmm14, %r11
               	movq	%r11, (%rcx)
               	movq	-0x10(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rbx,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x8(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pextrq	$0x1, %xmm14, %r11
               	movq	%r11, (%rcx)
               	movq	-0x8(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movl	$0x7, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movl	$0x10, %r14d
               	leaq	-0x50(%rbp), %rsi
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	%r13, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x45(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pinsrb	$0xb, %r13d, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x60(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r14d
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r13, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rcx,%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pinsrd	$0x2, %r13d, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x60(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r14d
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r12, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rcx,%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	pinsrq	$0x1, %r12, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x60(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %r14d
               	movq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<check_ptest>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r15
               	movzbq	(%r15), %rax
               	movzbq	(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x28(%rbp)
               	movzbq	0x1(%r15), %rax
               	movzbq	0x1(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x27(%rbp)
               	movzbq	0x2(%r15), %rax
               	movzbq	0x2(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x26(%rbp)
               	movzbq	0x3(%r15), %rax
               	movzbq	0x3(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x25(%rbp)
               	movzbq	0x4(%r15), %rax
               	movzbq	0x4(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x24(%rbp)
               	movzbq	0x5(%r15), %rax
               	movzbq	0x5(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x23(%rbp)
               	movzbq	0x6(%r15), %rax
               	movzbq	0x6(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x22(%rbp)
               	movzbq	0x7(%r15), %rax
               	movzbq	0x7(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x21(%rbp)
               	movzbq	0x8(%r15), %rax
               	movzbq	0x8(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x20(%rbp)
               	movzbq	0x9(%r15), %rax
               	movzbq	0x9(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1f(%rbp)
               	movzbq	0xa(%r15), %rax
               	movzbq	0xa(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1e(%rbp)
               	movzbq	0xb(%r15), %rax
               	movzbq	0xb(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1d(%rbp)
               	movzbq	0xc(%r15), %rax
               	movzbq	0xc(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1c(%rbp)
               	movzbq	0xd(%r15), %rax
               	movzbq	0xd(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1b(%rbp)
               	movzbq	0xe(%r15), %rax
               	movzbq	0xe(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x1a(%rbp)
               	movzbq	0xf(%r15), %rax
               	movzbq	0xf(%rsi), %rcx
               	andq	%rcx, %rax
               	andq	$0x11, %rax
               	movb	%al, -0x19(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%r15, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %r12
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rdx, %r8
               	leaq	-0x18(%rbp), %r9
               	movq	(%r9,%rax,8), %r9
               	movzbq	(%r9,%rcx), %r9
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi,%rsi,8), %rdi
               	movzbq	(%rdi,%rcx), %rdi
               	andq	%rdi, %r9
               	testl	%r9d, %r9d
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %r8
               	leaq	-0x18(%rbp), %r9
               	movq	(%r9,%rax,8), %r9
               	movzbq	(%r9,%rcx), %r9
               	xorq	$-0x1, %r9
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi,%rsi,8), %rdi
               	movzbq	(%rdi,%rcx), %rdi
               	andq	%rdi, %r9
               	testl	%r9d, %r9d
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx,%rax,8), %rcx
               	leaq	-0xc0(%rbp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movq	-0xc0(%rbp), %rcx
               	movq	-0xb8(%rbp), %r9
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi,%rsi,8), %rdi
               	leaq	-0xb0(%rbp), %rbx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rbx)
               	movq	-0xb0(%rbp), %rdi
               	movq	-0xa8(%rbp), %rbx
               	movq	%rcx, %r13
               	andq	%rdi, %r13
               	movq	%r9, %r14
               	andq	%rbx, %r14
               	orq	%r14, %r13
               	testq	%r13, %r13
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpl	%r8d, %r13d
               	jne	<addr>
               	movq	%rcx, %r13
               	xorq	$-0x1, %r13
               	movq	%r9, %r14
               	xorq	$-0x1, %r14
               	andq	%rdi, %r13
               	andq	%rbx, %r14
               	orq	%r14, %r13
               	testq	%r13, %r13
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpl	%edx, %r13d
               	jne	<addr>
               	movq	%rcx, %r13
               	andq	%rdi, %r13
               	movq	%r9, %r14
               	andq	%rbx, %r14
               	orq	%r14, %r13
               	xorl	%r14d, %r14d
               	testq	%r13, %r13
               	je	<addr>
               	movq	%rcx, %r13
               	xorq	$-0x1, %r13
               	movq	%r9, %r14
               	xorq	$-0x1, %r14
               	andq	%rdi, %r13
               	andq	%rbx, %r14
               	orq	%r14, %r13
               	testq	%r13, %r13
               	sete	%r13b
               	movzbq	%r13b, %r13
               	testl	%r13d, %r13d
               	sete	%r14b
               	movzbq	%r14b, %r14
               	xorl	%r13d, %r13d
               	testl	%r8d, %r8d
               	jne	<addr>
               	testl	%edx, %edx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpl	%r13d, %r14d
               	jne	<addr>
               	movq	%rcx, %r13
               	andq	%rdi, %r13
               	movq	%r9, %r14
               	andq	%rbx, %r14
               	orq	%r13, %r14
               	xorl	%r13d, %r13d
               	testq	%r14, %r14
               	je	<addr>
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %r9
               	andq	%rdi, %rcx
               	andq	%rbx, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	xorl	%ecx, %ecx
               	testl	%r8d, %r8d
               	jne	<addr>
               	testl	%edx, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %r13d
               	je	<addr>
               	movl	$0x20, %r12d
               	incq	%rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movzbq	(%r15), %rax
               	cmpl	$0xff, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movzbq	0x1(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x2(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x3(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x4(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x5(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x6(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x7(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x8(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0x9(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xa(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xb(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xc(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xd(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xe(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movzbq	0xf(%r15), %rcx
               	cmpl	$0xff, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	andq	%rcx, %rdx
               	leaq	-0xb0(%rbp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%r15), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rsi
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rsi)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	movq	-0x80(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	andq	%rsi, %rax
               	andq	%rdi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%edx, %eax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, -0xb0(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xac(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa8(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0xa4(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x70(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movl	$0xffffffff, -0x70(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x6c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x68(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x64(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x70(%rbp), %rcx
               	leaq	-0x60(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0xffffffff, -0x60(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x5c(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, -0x58(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x60(%rbp), %rdx
               	movl	$0xffffffff, -0x54(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x50(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pcmpeqd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	movq	-0x48(%rbp), %rsi
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	andq	%rdx, %rax
               	andq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r12d
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_minpos>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%r8d, %r8d
               	movl	$0x1, %esi
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	movq	%r8, %r9
               	shlq	%r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpq	%rdx, %rcx
               	jae	<addr>
               	movq	%rsi, %r8
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movq	%r8, %rsi
               	shlq	%rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %rcx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shrxq	%rsi, %r8, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rcx,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	movswq	(%rdx,%rax,2), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movswq	(%rdx,%rcx,2), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	%edi, %esi
               	jge	<addr>
               	movq	%rax, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movswq	(%rax,%rcx,2), %rax
               	movw	%ax, -0x30(%rbp)
               	movw	%cx, -0x2e(%rbp)
               	movw	$0x0, -0x2c(%rbp)
               	movw	$0x0, -0x2a(%rbp)
               	movw	$0x0, -0x28(%rbp)
               	movw	$0x0, -0x26(%rbp)
               	movw	$0x0, -0x24(%rbp)
               	movw	$0x0, -0x22(%rbp)
               	movups	-0x30(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	%xmm0, -0x30(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x40, %eax
               	jmp	<addr>

<check_mpsadbw>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movzbq	(%r12,%rax), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	movsbq	(%rdi,%rax), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x4(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	leaq	0x4(%rax), %r8
               	movsbq	(%rdi,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x8(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	leaq	0x8(%rax), %r8
               	movsbq	(%rdi,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	(%rdx,%rax), %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0xc(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	(%rsi,%rax), %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	leaq	0xc(%rax), %r8
               	movsbq	(%rdi,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	0x4(%rdx), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movzbq	(%r12,%rax), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	0x4(%rsi), %rdi
               	addq	%rax, %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	movsbq	(%rdi,%rax), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	0x4(%rdx), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x4(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	0x4(%rsi), %rdi
               	addq	%rax, %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	leaq	0x4(%rax), %r8
               	movsbq	(%rdi,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	0x4(%rdx), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0x8(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	0x4(%rsi), %rdi
               	addq	%rax, %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	leaq	0x8(%rax), %r8
               	movsbq	(%rdi,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	leaq	0x4(%rdx), %rcx
               	addq	%rax, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	leaq	0xc(%rax), %rdi
               	movzbq	(%r12,%rdi), %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rsi
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	movq	%rdx, %rdi
               	shlq	%rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rcx,%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x8, %edx
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x60(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	0x4(%rsi), %rdi
               	addq	%rax, %rdi
               	movsbq	(%rcx,%rdi), %rcx
               	andq	$0xff, %rcx
               	leaq	-0x30(%rbp), %rdi
               	leaq	0xc(%rax), %r8
               	movsbq	(%rdi,%r8), %rdi
               	andq	$0xff, %rdi
               	subq	%rdi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movw	%dx, (%rax,%rsi,2)
               	incq	%rsi
               	cmpl	$0x8, %esi
               	jl	<addr>
               	movups	-0xb0(%rbp), %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rax
               	movups	%xmm0, -0xa0(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	leaq	<rip>, %rax # <addr>
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rcx
               	movdqu	(%rax), %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %r13d
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%r13d, %r13d
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b8, %rsp            # imm = 0x1B8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x188(%rsp)
               	movq	0x188(%rsp), %r11
               	movq	%r11, 0x180(%rsp)
               	leaq	-0x50(%rbp), %rdx
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
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
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
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rdx
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
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x188(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rbx
               	leaq	-0x40(%rbp), %r12
               	leaq	-0x110(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1b0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x100(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1a0(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x190(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	leaq	-0xf0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pminsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xe0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaxsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x10, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xd0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pminuw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x20, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xc0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaxuw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x30, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xb0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pminsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x40, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaxsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x50, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0x90(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pminud	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x60, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1b0(%rbp), %rcx
               	leaq	-0x1a0(%rbp), %rdx
               	leaq	-0x80(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	pmaxud	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x190(%rbp), %rcx
               	addq	$0x70, %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%r15d, %r15d
               	leaq	<rip>, %rax # <addr>
               	movq	%r15, %rcx
               	shrq	%rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	xorl	%edi, %edi
               	movl	(%rax), %esi
               	movslq	0x4(%rax), %r13
               	movq	%r15, %r14
               	andq	$0x1, %r14
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %edi
               	jge	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x1(%rsi), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %esi
               	jge	<addr>
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%edx, %edx
               	leaq	-0x1(%rsi), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rsi, %r8
               	imulq	%rdi, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%r12,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %esi
               	jge	<addr>
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rsi, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shlxq	%r8, %rax, %rax
               	orq	%rax, %rdx
               	testq	%r13, %r13
               	je	<addr>
               	cmpq	%rdx, %rcx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%r14, %r14
               	je	<addr>
               	xorl	%r8d, %r8d
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	%rdx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	leaq	-0x20(%rbp), %r8
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	jmp	<addr>
               	cmpq	%rdx, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	incq	%rdi
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %edi
               	jl	<addr>
               	leaq	-0x190(%rbp), %rax
               	movq	%r15, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	cmpl	$0x8, %r15d
               	jl	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	0x180(%rsp), %rbx
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, 0x180(%rsp)
               	movq	0x188(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x188(%rsp)
               	movq	0x188(%rsp), %rax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jl	<addr>
               	movq	0x180(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
