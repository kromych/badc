
ssse3_abs_sign_horizontal_and_alignr_follow_the_sdm.x64:	file format elf64-x86-64

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

<model_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r14
               	movslq	%r8d, %r11
               	movq	%r11, 0x40(%rsp)
               	movslq	%ecx, %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rdx, %rbx
               	movq	%rsi, %r15
               	movl	$0x8, %eax
               	cltd
               	idivl	%ebx
               	movq	%rax, %r13
               	xorl	%r12d, %r12d
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r12d
               	jge	<addr>
               	cmpl	%r13d, %r12d
               	jge	<addr>
               	movq	%r14, %rdi
               	movl	%r12d, %eax
               	cltd
               	idivl	%r13d
               	movq	%rdx, %rcx
               	shlq	%rcx
               	xorl	%edx, %edx
               	leaq	-0x1(%rbx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rdx
               	leaq	0x1(%rcx), %rsi
               	xorl	%ecx, %ecx
               	leaq	-0x1(%rbx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%rbx, %r8
               	imulq	%rsi, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rcx
               	movq	0x48(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	subq	%rcx, %rdx
               	movq	0x40(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	movslq	%ecx, %rcx
               	shlxq	%rcx, %rax, %rax
               	decq	%rax
               	cmpq	%rax, %rdx
               	jle	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rcx
               	imulq	%r12, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rdx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%r9,%rcx)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	cmpq	%rcx, %rdx
               	jge	<addr>
               	movq	%rax, %rdx
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	jmp	<addr>
               	movq	%r15, %rdi
               	jmp	<addr>
               	incq	%r12
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r12d
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_mulhrs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x2(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x2(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x4(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x6(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x6(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xa(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0xa(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0xc(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xe(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rcx         # imm = 0xFFFF0000
               	xorl	%edx, %edx
               	movl	$0x1, %eax
               	shlq	$0x8, %rdx
               	leaq	0xe(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0xf, %rax
               	testb	$0x1, %al
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	imulq	%rcx, %rdx
               	sarq	$0xe, %rdx
               	leaq	0x1(%rdx), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %rdx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rdx)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	pmulhrsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
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
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x10, %eax
               	jmp	<addr>

<check_alignr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x248, %rsp            # imm = 0x248
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movzbq	(%r12,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x240(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x230(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x220(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x0, %xmm14, %xmm15    # xmm15 = xmm14[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%r12,%rcx), %rdx
               	jmp	<addr>
               	movzbq	(%rbx), %rdx
               	movb	%dl, (%rsi,%rax)
               	movq	%rcx, %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x210(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x200(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1f0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x1, %xmm14, %xmm15    # xmm15 = xmm14[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm15[0]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	leaq	0x5(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%r12,%rcx), %rcx
               	jmp	<addr>
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x1e0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1d0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x1c0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x5, %xmm14, %xmm15    # xmm15 = xmm14[5,6,7,8,9,10,11,12,13,14,15],xmm15[0,1,2,3,4]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	leaq	0x8(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%r12,%rcx), %rcx
               	jmp	<addr>
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x1b0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1a0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x190(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x8, %xmm14, %xmm15    # xmm15 = xmm14[8,9,10,11,12,13,14,15],xmm15[0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	leaq	0xf(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	0xf(%r12), %rcx
               	jmp	<addr>
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x180(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x170(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x160(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0xf, %xmm14, %xmm15    # xmm15 = xmm14[15],xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x140(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x130(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x10, %xmm14, %xmm15   # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x11(%rax), %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x120(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x110(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x100(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x11, %xmm14, %xmm15   # xmm15 = xmm15[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x18(%rax), %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xd0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x18, %xmm14, %xmm15   # xmm15 = xmm15[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	0x1f(%rax), %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	movzbq	0xf(%rbx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x1f, %xmm14, %xmm15   # xmm15 = xmm15[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x20, %xmm14, %xmm15   # xmm15 = xmm15[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rcx
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	palignr	$0x28, %xmm14, %xmm15   # xmm15 = xmm15[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
               	movdqu	%xmm15, (%rdx)
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x30(%rbp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %r13d
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
               	subq	$0x1f8, %rsp            # imm = 0x1F8
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r14d, %r14d
               	movq	%r14, %r13
               	leaq	-0x60(%rbp), %rdx
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
               	leaq	-0x60(%rbp), %rbx
               	xorl	%r12d, %r12d
               	movl	$0x1, %eax
               	shlxq	%r12, %rax, %rsi
               	xorl	%edi, %edi
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
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movslq	%eax, %rax
               	shlxq	%rax, %rdx, %rax
               	orq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	%r12, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	testq	%rcx, %rcx
               	jge	<addr>
               	negq	%rcx
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rsi, %r8
               	imulq	%rdi, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%rdi
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %edi
               	jl	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	leaq	-0x1f0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1e0(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pabsb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x190(%rbp), %rax
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
               	jne	<addr>
               	leaq	-0x1d0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1c0(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pabsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	-0x190(%rbp), %rax
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
               	jne	<addr>
               	leaq	-0x1b0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x1a0(%rbp), %rcx
               	movdqu	(%rax), %xmm14
               	pabsd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rcx)
               	leaq	-0x30(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	-0x190(%rbp), %rax
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
               	jne	<addr>
               	xorl	%eax, %eax
               	movq	%r13, %r15
               	orq	%rax, %r15
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x50(%rbp), %r9
               	xorl	%r13d, %r13d
               	movl	$0x1, %eax
               	shlxq	%r13, %rax, %rsi
               	xorl	%edi, %edi
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
               	movzbq	(%r8,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
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
               	movq	%rsi, %rbx
               	imulq	%rdi, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%r9,%rbx), %rbx
               	orq	%rbx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rsi, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rsi, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	shlxq	%rbx, %rax, %rax
               	orq	%rax, %rdx
               	leaq	-0x30(%rbp), %rax
               	movq	%r13, %rbx
               	shlq	$0x4, %rbx
               	addq	%rax, %rbx
               	testq	%rdx, %rdx
               	jge	<addr>
               	negq	%rcx
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rbx,%rdx)
               	incq	%rax
               	cmpl	%esi, %eax
               	jge	<addr>
               	jmp	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rdi
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %edi
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x3, %r13d
               	jl	<addr>
               	leaq	-0x160(%rbp), %rax
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x180(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x150(%rbp), %rax
               	movups	(%r9), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x170(%rbp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x140(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psignb	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x180(%rbp), %rcx
               	leaq	-0x170(%rbp), %rdx
               	leaq	-0x130(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psignw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	leaq	0x10(%rcx), %rsi
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x180(%rbp), %rcx
               	leaq	-0x170(%rbp), %rdx
               	leaq	-0x120(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	psignd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	leaq	0x20(%rcx), %rsi
               	leaq	-0x110(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	orq	%rax, %r15
               	leaq	-0x60(%rbp), %rbx
               	leaq	-0x50(%rbp), %r12
               	leaq	-0x100(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x180(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0xf0(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x170(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%r13d, %r13d
               	movl	$0x2, %edx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r13, %r8
               	movq	%r13, %rcx
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0xe0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	phaddw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	phaddd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xd0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0xc0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	phsubw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0xb0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	phsubd	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%r13, %r10
               	orq	%rax, %r10
               	movq	%r10, 0x1b8(%rsp)
               	xorl	%r13d, %r13d
               	movl	$0x2, %edx
               	movl	$0x1, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r13, %rcx
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0xa0(%rbp), %rdx
               	movdqu	(%rax), %xmm15
               	movdqu	(%rcx), %xmm14
               	phaddsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rdx)
               	leaq	-0xa0(%rbp), %rax
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	-0x180(%rbp), %rcx
               	leaq	-0x170(%rbp), %rdx
               	leaq	-0x90(%rbp), %rax
               	movdqu	(%rcx), %xmm15
               	movdqu	(%rdx), %xmm14
               	phsubsw	%xmm14, %xmm15
               	movdqu	%xmm15, (%rax)
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r13
               	movq	0x1b8(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%r13, %r13
               	je	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	orq	%rcx, %rax
               	orq	%rax, %r15
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	callq	<addr>
               	movq	%r15, %r13
               	orq	%rax, %r13
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r13
               	incq	%r14
               	cmpl	$0x190, %r14d           # imm = 0x190
               	jl	<addr>
               	movq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
