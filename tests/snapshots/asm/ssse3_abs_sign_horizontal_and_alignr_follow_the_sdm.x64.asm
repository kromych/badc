
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

<check_sign>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	movl	$0x1, %eax
               	shlxq	%r13, %rax, %rcx
               	xorl	%r9d, %r9d
               	movl	$0x10, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %r8
               	imulq	%r9, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	testb	$0x1, %r8b
               	je	<addr>
               	movq	$-0x1, %r8
               	movslq	%eax, %rax
               	shlxq	%rax, %r8, %rax
               	orq	%rax, %rdx
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rbx
               	imulq	%r9, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rbx
               	movslq	%ebx, %rbx
               	shrxq	%rbx, %r8, %rbx
               	testb	$0x1, %bl
               	je	<addr>
               	movq	$-0x1, %rbx
               	movslq	%eax, %rax
               	shlxq	%rax, %rbx, %rax
               	orq	%rax, %r8
               	leaq	-0x30(%rbp), %rax
               	movq	%r13, %rbx
               	shlq	$0x4, %rbx
               	addq	%rax, %rbx
               	testq	%r8, %r8
               	jge	<addr>
               	negq	%rdx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %r8
               	imulq	%r9, %r8
               	addq	%rax, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rdx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rbx,%r8)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	testq	%r8, %r8
               	cmoveq	%rax, %rdx
               	jmp	<addr>
               	incq	%r9
               	movl	$0x10, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x3, %r13d
               	jl	<addr>
               	movups	(%rdi), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	psignb	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	psignw	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	psignd	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<model_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r15
               	movq	%rcx, 0x40(%rsp)
               	movq	%rdx, %rbx
               	movq	%rsi, 0x48(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%ebx
               	movq	%rax, %r14
               	xorl	%r13d, %r13d
               	movq	%r14, %rax
               	shlq	%rax
               	cmpl	%eax, %r13d
               	jge	<addr>
               	cmpl	%r14d, %r13d
               	movq	0x48(%rsp), %r11
               	movq	%r11, %r12
               	cmovlq	%r15, %r12
               	movl	%r13d, %eax
               	cltd
               	idivl	%r14d
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
               	movzbq	(%r12,%rsi), %rsi
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
               	movq	%rbx, %rdi
               	imulq	%rsi, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rcx
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
               	movq	%rdx, %rax
               	subq	%rcx, %rax
               	addq	%rdx, %rcx
               	movq	0x40(%rsp), %r10
               	testl	%r10d, %r10d
               	movq	%rcx, %rdx
               	cmovneq	%rax, %rdx
               	testl	%r8d, %r8d
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
               	imulq	%r13, %rcx
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
               	xorq	$-0x1, %rax
               	cmpq	%rcx, %rdx
               	cmovlq	%rax, %rdx
               	jmp	<addr>
               	incq	%r13
               	movq	%r14, %rax
               	shlq	%rax
               	cmpl	%eax, %r13d
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movups	(%rbx), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	(%r12), %xmm14
               	movups	%xmm14, 0x20(%rsp)
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	phaddw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %r13
               	orq	%rax, %r13
               	movl	$0x4, %edx
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	phaddd	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
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
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	phsubw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
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
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	phsubd	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
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
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	movl	$0x1, %r8d
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	phaddsw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %r14
               	orq	%rax, %r14
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x20(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm0
               	phsubsw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
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
               	orq	%r14, %rax
               	movl	$0x4, %ecx
               	xorl	%edx, %edx
               	testq	%r13, %r13
               	cmoveq	%rdx, %rcx
               	movl	$0x8, %edx
               	xorl	%esi, %esi
               	testq	%rax, %rax
               	movq	%rsi, %rax
               	cmovneq	%rdx, %rax
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<check_mulhrs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rsi,%rax), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	shrxq	%r8, %rcx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x2(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x2(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x6(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x6(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xa(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xa(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xe(%rax), %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %r9
               	cmovneq	%r8, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xe(%rax), %r8
               	movzbq	(%rsi,%r8), %r8
               	orq	%r8, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r8
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	movq	%rcx, %rax
               	cmovneq	%r8, %rax
               	imulq	%r9, %rax
               	sarq	$0xe, %rax
               	leaq	0x1(%rax), %rcx
               	sarq	%rcx
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %r8
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rcx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rdx,%r8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	pmulhrsw	%xmm1, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x10, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	leave
               	retq

<check_alignr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x0, %xmm1, %xmm0      # xmm0 = xmm1[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r13
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x1, %xmm1, %xmm0      # xmm0 = xmm1[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm0[0]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x5, %xmm1, %xmm0      # xmm0 = xmm1[5,6,7,8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x8, %xmm1, %xmm0      # xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0xf, %xmm1, %xmm0      # xmm0 = xmm1[15],xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x10, %xmm1, %xmm0     # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x11, %xmm1, %xmm0     # xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x18, %xmm1, %xmm0     # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
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
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x1f, %xmm1, %xmm0     # xmm0 = xmm0[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x20, %xmm1, %xmm0     # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	palignr	$0x28, %xmm1, %xmm0     # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x10(%rbp), %rdi
               	movups	%xmm0, -0x10(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	movq	%r13, %rax
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	movq	%r13, %r14
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
               	leaq	-0x60(%rbp), %r8
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
               	movzbq	(%r8,%rdx), %rdx
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
               	movq	%rcx, %rax
               	negq	%rax
               	testq	%rcx, %rcx
               	cmovlq	%rax, %rcx
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movq	%rsi, %r9
               	imulq	%rdi, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movq	%rax, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %rbx
               	shrxq	%rbx, %rcx, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%rdx,%r9)
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
               	movups	-0x60(%rbp), %xmm0
               	pabsb	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	-0x60(%rbp), %xmm0
               	pabsw	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	-0x60(%rbp), %xmm0
               	pabsd	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%r14, %rbx
               	orq	%rax, %rbx
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	-0x60(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	callq	<addr>
               	movq	%rbx, %r14
               	orq	%rax, %r14
               	incq	%r13
               	cmpl	$0x190, %r13d           # imm = 0x190
               	jl	<addr>
               	movq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
