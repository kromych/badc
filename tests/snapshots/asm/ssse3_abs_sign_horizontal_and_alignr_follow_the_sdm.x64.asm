
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
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1, %ecx
               	movq	0x38(%rsp), %rax
               	shlxq	%rax, %rcx, %r9
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r9), %r8
               	movq	%r9, %rcx
               	shlq	$0x3, %rcx
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %r15
               	movslq	%ecx, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%rax, %r10
               	shlq	$0x4, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x10, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rdi,%rbx), %rbx
               	orq	%rbx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	shrxq	%r15, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x48(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%r9, %rbx
               	imulq	%r14, %rbx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%rbx,%rax), %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	shrxq	%r15, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x48(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rbx
               	addq	0x40(%rsp), %rbx
               	testq	%rdx, %rdx
               	jge	<addr>
               	negq	%rcx
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	xorl	%eax, %eax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r13
               	shlq	$0x3, %r13
               	movslq	%r13d, %r13
               	shrxq	%r13, %rcx, %r13
               	andq	$0xff, %r13
               	movb	%r13b, (%rbx,%r12)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jge	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	cmoveq	%rax, %rcx
               	jmp	<addr>
               	incq	%r14
               	movl	$0x10, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jl	<addr>
               	movq	0x38(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movups	(%rdi), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpsignb	%xmm15, %xmm14, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x40(%rbp), %rdi
               	movups	%xmm0, -0x40(%rbp)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpsignw	%xmm15, %xmm14, %xmm0
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
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpsignd	%xmm15, %xmm14, %xmm0
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
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<model_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x50(%rsp)
               	movq	%r8, 0x38(%rsp)
               	movq	%rcx, 0x40(%rsp)
               	movq	%rdx, %r13
               	movq	%rsi, 0x48(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%r13d
               	movq	%rax, %r8
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r13), %rbx
               	movq	%r13, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %r15
               	movslq	%eax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%r8, %r10
               	shlq	%r10
               	movq	%r10, 0x30(%rsp)
               	cmpl	0x30(%rsp), %r14d
               	jge	<addr>
               	cmpl	%r8d, %r14d
               	movq	0x50(%rsp), %r10
               	movq	0x48(%rsp), %r11
               	movq	%r11, %r12
               	cmovlq	%r10, %r12
               	movl	%r14d, %eax
               	cltd
               	idivl	%r8d
               	movq	%rdx, %rdi
               	shlq	%rdi
               	xorl	%ecx, %ecx
               	movq	%r13, %rdx
               	imulq	%rdi, %rdx
               	movq	%rbx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	shrxq	%r15, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x58(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rcx
               	leaq	0x1(%rdi), %rsi
               	xorl	%edx, %edx
               	imulq	%r13, %rsi
               	movq	%rbx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	leaq	(%rsi,%rax), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	shrxq	%r15, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	0x58(%rsp), %r10
               	shlxq	%r10, %rax, %rax
               	orq	%rax, %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	addq	%rdx, %rcx
               	movq	0x40(%rsp), %r10
               	testl	%r10d, %r10d
               	cmovneq	%rax, %rcx
               	movq	0x38(%rsp), %r10
               	testl	%r10d, %r10d
               	je	<addr>
               	movl	$0x1, %eax
               	shlxq	%r15, %rax, %rax
               	leaq	-0x1(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jle	<addr>
               	movq	%rdx, %rcx
               	movq	%r13, %rdx
               	imulq	%r14, %rdx
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rcx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r9,%rsi)
               	incq	%rax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%rdx, %rax
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	cmpq	%rax, %rcx
               	cmovlq	%rdx, %rcx
               	jmp	<addr>
               	incq	%r14
               	cmpl	0x30(%rsp), %r14d
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphaddw	%xmm15, %xmm14, %xmm0
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphaddd	%xmm15, %xmm14, %xmm0
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphsubw	%xmm15, %xmm14, %xmm0
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphsubd	%xmm15, %xmm14, %xmm0
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphaddsw	%xmm15, %xmm14, %xmm0
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
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphsubsw	%xmm15, %xmm14, %xmm0
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
               	vpmulhrsw	%xmm1, %xmm0, %xmm0
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
               	vpalignr	$0x0, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
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
               	vpalignr	$0x1, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm0[0]
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
               	vpalignr	$0x5, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[5,6,7,8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4]
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
               	vpalignr	$0x8, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
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
               	vpalignr	$0xf, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[15],xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
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
               	vpalignr	$0x10, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
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
               	vpalignr	$0x11, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
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
               	vpalignr	$0x18, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
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
               	vpalignr	$0x1f, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
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
               	vpalignr	$0x20, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
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
               	vpalignr	$0x28, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
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
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r11
               	movq	%r11, 0x30(%rsp)
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
               	leaq	-0x60(%rbp), %rdi
               	xorl	%r10d, %r10d
               	movq	%r10, 0x40(%rsp)
               	movl	$0x1, %ecx
               	movq	0x40(%rsp), %rax
               	shlxq	%rax, %rcx, %rsi
               	leaq	-0x1(%rsi), %r8
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %r14
               	movslq	%ecx, %r15
               	movq	%rax, %r10
               	shlq	$0x4, %r10
               	movq	%r10, 0x48(%rsp)
               	xorl	%r13d, %r13d
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r13d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rsi, %rdx
               	imulq	%r13, %rdx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %r9
               	movslq	%r9d, %r9
               	movzbq	(%rdi,%r9), %r9
               	orq	%r9, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	shrxq	%r14, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	shlxq	%r15, %rax, %rax
               	orq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rdx
               	addq	0x48(%rsp), %rdx
               	movq	%rcx, %rax
               	negq	%rax
               	testq	%rcx, %rcx
               	movq	%rcx, %r9
               	cmovlq	%rax, %r9
               	movq	%rsi, %rcx
               	imulq	%r13, %rcx
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%rcx,%rax), %rbx
               	movslq	%ebx, %rbx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %r9, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r13
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r13d
               	jl	<addr>
               	movq	0x40(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %rax
               	cmpl	$0x3, %eax
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
               	movq	0x30(%rsp), %rbx
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
               	movq	%rbx, %r10
               	orq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	cmpl	$0x190, %eax            # imm = 0x190
               	jl	<addr>
               	movq	0x30(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
