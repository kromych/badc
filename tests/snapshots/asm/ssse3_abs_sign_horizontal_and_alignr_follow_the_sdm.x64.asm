
ssse3_abs_sign_horizontal_and_alignr_follow_the_sdm.x64:	file format elf64-x86-64

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

<check_sign>:
               	subq	$0x70, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	shlxq	%r15, %rax, %r9
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r9), %r8
               	movl	$0x10, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%r9, %rdx
               	imulq	%r14, %rdx
               	movq	%r8, %rax
               	nop
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rdx,%rax), %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rdi,%rbx), %rbx
               	orq	%rbx, %rcx
               	decq	%rax
               	nopw	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r9, %rdx
               	shlq	$0x3, %rdx
               	leaq	-0x1(%rdx), %rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rcx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rax, %rax
               	orq	%rax, %rcx
               	xorl	%eax, %eax
               	movq	%r9, %rbx
               	imulq	%r14, %rbx
               	movq	%r8, %rdx
               	nopl	(%rax)
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rbx,%rdx), %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %rax
               	decq	%rdx
               	nopw	(%rax,%rax)
               	testl	%edx, %edx
               	jge	<addr>
               	movq	%r9, %rbx
               	shlq	$0x3, %rbx
               	leaq	-0x1(%rbx), %rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	nopw	(%rax,%rax)
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movslq	%ebx, %rbx
               	shlxq	%rbx, %rdx, %rdx
               	orq	%rdx, %rax
               	leaq	0x60(%rsp), %rdx
               	movq	%r15, %rbx
               	shlq	$0x4, %rbx
               	leaq	(%rdx,%rbx), %r12
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rcx, %rdx
               	negq	%rdx
               	movq	%r9, %rbx
               	imulq	%r14, %rbx
               	xorl	%eax, %eax
               	nopl	(%rax,%rax)
               	cmpl	%r9d, %eax
               	jge	<addr>
               	leaq	(%rbx,%rax), %rcx
               	movslq	%ecx, %r13
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r12,%r13)
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	jmp	<addr>
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmovneq	%rcx, %rdx
               	jmp	<addr>
               	incq	%r14
               	movl	$0x10, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r14d
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x3, %r15d
               	jl	<addr>
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	vpsignb	%xmm1, %xmm0, %xmm2
               	leaq	0x60(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm2, 0x50(%rsp)
               	movl	$0x10, %edx
               	movups	%xmm0, 0x40(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpsignw	%xmm15, %xmm14, %xmm0
               	leaq	0x60(%rsp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x40(%rsp), %xmm14
               	movups	0x30(%rsp), %xmm15
               	vpsignd	%xmm15, %xmm14, %xmm0
               	leaq	0x60(%rsp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
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
               	addq	$0x70, %rsp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<model_horizontal>:
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdx, %r13
               	movq	%rsi, 0x40(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%r13d
               	movq	%rax, %r15
               	xorl	%r14d, %r14d
               	leaq	-0x1(%r13), %rbx
               	movq	%r13, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rbp
               	movslq	%eax, %r8
               	movq	%r15, %rax
               	shlq	%rax
               	cmpl	%eax, %r14d
               	jge	<addr>
               	cmpl	%r15d, %r14d
               	movq	0x48(%rsp), %r10
               	movq	0x40(%rsp), %r11
               	movq	%r11, %r12
               	cmovlq	%r10, %r12
               	movl	%r14d, %eax
               	cltd
               	idivl	%r15d
               	movq	%rdx, %rdi
               	shlq	%rdi
               	xorl	%eax, %eax
               	movq	%r13, %rdx
               	imulq	%rdi, %rdx
               	movq	%rbx, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rax
               	decq	%rcx
               	nop
               	testl	%ecx, %ecx
               	jge	<addr>
               	shrxq	%rbp, %rax, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rcx
               	shlxq	%r8, %rcx, %rcx
               	orq	%rcx, %rax
               	leaq	0x1(%rdi), %rsi
               	xorl	%ecx, %ecx
               	imulq	%r13, %rsi
               	movq	%rbx, %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	leaq	(%rsi,%rdx), %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	shrxq	%rbp, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	shlxq	%r8, %rdx, %rdx
               	orq	%rdx, %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %r10
               	testl	%r10d, %r10d
               	cmoveq	%rax, %rdx
               	movq	0x30(%rsp), %r10
               	nopl	(%rax,%rax)
               	testl	%r10d, %r10d
               	je	<addr>
               	movl	$0x1, %eax
               	shlxq	%rbp, %rax, %rax
               	decq	%rax
               	cmpq	%rax, %rdx
               	jle	<addr>
               	movq	%rax, %rdx
               	movq	%r13, %rsi
               	imulq	%r14, %rsi
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	leaq	(%rsi,%rax), %rcx
               	movslq	%ecx, %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r9,%rdi)
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rax
               	cmpq	%rcx, %rdx
               	cmovlq	%rax, %rdx
               	jmp	<addr>
               	incq	%r14
               	movq	%r15, %rax
               	shlq	%rax
               	cmpl	%eax, %r14d
               	jl	<addr>
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x28, %rsp
               	retq

<check_horizontal>:
               	subq	$0x48, %rsp
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
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphaddw	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	xorl	%eax, %eax
               	orq	%rax, %r13
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphaddd	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
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
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphsubw	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
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
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphsubd	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
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
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphaddsw	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
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
               	leaq	0x40(%rsp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x20(%rsp), %xmm15
               	vphsubsw	%xmm15, %xmm14, %xmm0
               	leaq	0x40(%rsp), %rsi
               	leaq	0x50(%rsp), %rdi
               	movups	%xmm0, 0x50(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	orq	%rax, %r14
               	movl	$0x4, %eax
               	xorl	%ecx, %ecx
               	testq	%r13, %r13
               	cmoveq	%rcx, %rax
               	movl	$0x8, %ecx
               	xorl	%edx, %edx
               	testq	%r14, %r14
               	cmoveq	%rdx, %rcx
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x48, %rsp
               	retq

<check_mulhrs>:
               	subq	$0x28, %rsp
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nopw	(%rax,%rax)
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rsi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%rax)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x2(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0x2(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x4(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0x4(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x6(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0x6(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xa(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0xa(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xc(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0xc(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
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
               	movq	%rcx, %r9
               	orq	$-0x10000, %r9          # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmoveq	%rcx, %r9
               	xorl	%ecx, %ecx
               	movl	$0x1, %eax
               	shlq	$0x8, %rcx
               	leaq	0xe(%rax), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	nop
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0xf, %rax
               	movq	%rcx, %rdx
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	testb	$0x1, %al
               	cmovneq	%rdx, %rcx
               	imulq	%rcx, %r9
               	sarq	$0xe, %r9
               	leaq	0x1(%r9), %rdx
               	sarq	%rdx
               	xorl	%eax, %eax
               	leaq	0xe(%rax), %r9
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rsp,%r9)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movups	(%rdi), %xmm0
               	movups	(%rsi), %xmm1
               	vpmulhrsw	%xmm1, %xmm0, %xmm0
               	leaq	(%rsp), %rsi
               	leaq	0x10(%rsp), %rdi
               	movups	%xmm0, 0x10(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x10, %edx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq

<check_alignr>:
               	subq	$0x30, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	xorl	%eax, %eax
               	movzbq	(%r12,%rax), %rdx
               	movb	%dl, 0x20(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x0, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %r13
               	cmovneq	%rcx, %r13
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	movq	%rdx, %rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rdx
               	cmpl	$0x10, %edx
               	jge	<addr>
               	movzbq	(%r12,%rdx), %rcx
               	nop
               	jmp	<addr>
               	movzbq	(%rbx), %rcx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x1, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm0[0]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x5(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%r12,%rcx), %rcx
               	nopl	(%rax)
               	jmp	<addr>
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x5, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[5,6,7,8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x8(%rax), %rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	(%r12,%rcx), %rcx
               	jmp	<addr>
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x8, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%eax, %eax
               	jmp	<addr>
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0xf(%rax), %rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movzbq	0xf(%r12), %rcx
               	jmp	<addr>
               	subq	$0x10, %rcx
               	movzbq	(%rbx,%rcx), %rcx
               	nop
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0xf, %xmm1, %xmm0, %xmm0 # xmm0 = xmm1[15],xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rdx
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	movb	%dl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x10, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, 0x20(%rsp,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x11(%rax), %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x11, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x18(%rax), %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	subq	$0x10, %rdx
               	movzbq	(%rbx,%rdx), %rdx
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x18, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movb	%dl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jge	<addr>
               	leaq	0x1f(%rax), %rdx
               	cmpl	$0x20, %edx
               	jge	<addr>
               	movzbq	0xf(%rbx), %rdx
               	nop
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x1f, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x20, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmovneq	%rcx, %r13
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	(%rbx), %xmm0
               	movups	(%r12), %xmm1
               	vpalignr	$0x28, %xmm1, %xmm0, %xmm0 # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
               	leaq	0x20(%rsp), %rsi
               	leaq	0x30(%rsp), %rdi
               	movups	%xmm0, 0x30(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x20, %ecx
               	testq	%rax, %rax
               	cmoveq	%r13, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq

<main>:
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rbp
               	jmp	<addr>
               	orq	%rax, %rbp
               	leaq	0x40(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	orq	%rax, %rbp
               	leaq	0x40(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	orq	%rax, %rbp
               	leaq	0x40(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	orq	%rax, %rbp
               	leaq	0x40(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	orq	%rax, %rbp
               	addq	$0x1, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	cmpl	$0x190, %eax            # imm = 0x190
               	jge	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, 0x40(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	movb	%al, 0x50(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rax
               	movq	%rax, %rsi
               	shrq	$0x3c, %rsi
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rax
               	andq	$0x3, %rax
               	movzbq	(%rsi,%rax), %rax
               	jmp	<addr>
               	shrq	$0x18, %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	shlxq	%r15, %rax, %rsi
               	leaq	-0x1(%rsi), %r8
               	movq	%r15, %r14
               	shlq	$0x4, %r14
               	xorl	%r13d, %r13d
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r13d
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rsi, %rdx
               	imulq	%r13, %rdx
               	movq	%r8, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %rax
               	leaq	(%rdx,%rcx), %r9
               	movslq	%r9d, %r9
               	movzbq	0x40(%rsp,%r9), %r9
               	orq	%r9, %rax
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	leaq	-0x1(%rdx), %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rax, %rcx
               	nopw	(%rax,%rax)
               	testb	$0x1, %cl
               	je	<addr>
               	movq	$-0x1, %rcx
               	movslq	%edx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	orq	%rcx, %rax
               	leaq	0x70(%rsp), %rcx
               	leaq	(%rcx,%r14), %r9
               	movq	%rax, %rbx
               	negq	%rbx
               	testq	%rax, %rax
               	cmovgeq	%rax, %rbx
               	movq	%rsi, %rdx
               	imulq	%r13, %rdx
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	(%rdx,%rax), %rcx
               	movslq	%ecx, %r12
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	shrxq	%rcx, %rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r9,%r12)
               	incq	%rax
               	nop
               	cmpl	%esi, %eax
               	jl	<addr>
               	incq	%r13
               	movl	$0x10, %eax
               	cltd
               	idivl	%esi
               	cmpl	%eax, %r13d
               	jl	<addr>
               	incq	%r15
               	nopl	(%rax,%rax)
               	cmpl	$0x3, %r15d
               	jl	<addr>
               	movups	0x40(%rsp), %xmm0
               	pabsb	%xmm0, %xmm0
               	leaq	0x70(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x40(%rsp), %xmm0
               	pabsw	%xmm0, %xmm0
               	leaq	0x70(%rsp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x40(%rsp), %xmm0
               	pabsd	%xmm0, %xmm0
               	leaq	0x70(%rsp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	%xmm0, 0x60(%rsp)
               	movl	$0x10, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rbp, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x78, %rsp
               	retq
