
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
               	subq	$0x78, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	movl	$0x1, %eax
               	shlxq	%r13, %rax, %r8
               	xorl	%r9d, %r9d
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %r9d
               	jge	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x1(%r8), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%r8, %rdx
               	imulq	%r9, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r8, %rax
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
               	xorl	%edx, %edx
               	leaq	-0x1(%r8), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%r8, %rbx
               	imulq	%r9, %rbx
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%r8, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rbx
               	movslq	%ebx, %rbx
               	shrxq	%rbx, %rdx, %rbx
               	testb	$0x1, %bl
               	je	<addr>
               	movq	$-0x1, %rbx
               	movslq	%eax, %rax
               	shlxq	%rax, %rbx, %rax
               	orq	%rax, %rdx
               	leaq	-0x30(%rbp), %rax
               	movq	%r13, %rbx
               	shlq	$0x4, %rbx
               	addq	%rax, %rbx
               	testq	%rdx, %rdx
               	jge	<addr>
               	negq	%rcx
               	xorl	%eax, %eax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	%r8, %rdx
               	imulq	%r9, %rdx
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movslq	%r12d, %r12
               	shrxq	%r12, %rcx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rbx,%rdx)
               	incq	%rax
               	cmpl	%r8d, %eax
               	jge	<addr>
               	jmp	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%r9
               	movl	$0x10, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %r9d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x3, %r13d
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x70(%rbp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	leaq	-0x70(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x70(%rbp), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	psignb	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x70(%rbp), %rax
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	psignw	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	psignd	%xmm14, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movups	%xmm0, -0x70(%rbp)
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

<check_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-0x50(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x50(%rbp), %xmm14
               	movups	%xmm14, 0x40(%rsp)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x50(%rbp), %xmm14
               	movups	%xmm14, 0x30(%rsp)
               	xorl	%ecx, %ecx
               	movl	$0x2, %edx
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	phaddw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
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
               	xorl	%ecx, %ecx
               	leaq	-0x20(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	movups	0x30(%rsp), %xmm14
               	movups	0x40(%rsp), %xmm0
               	phaddd	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
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
               	movups	0x40(%rsp), %xmm0
               	phsubw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
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
               	movups	0x40(%rsp), %xmm0
               	phsubd	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
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
               	movups	0x40(%rsp), %xmm0
               	phaddsw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
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
               	movups	0x40(%rsp), %xmm0
               	phsubsw	%xmm14, %xmm0
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x50(%rbp), %rax
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
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
               	orq	%rax, %r14
               	testq	%r13, %r13
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x8, %ecx
               	orq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<check_mulhrs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
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
               	leaq	-0x40(%rbp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x40(%rbp), %xmm0
               	movups	-0x30(%rbp), %xmm1
               	pmulhrsw	%xmm1, %xmm0
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
               	movl	$0x10, %eax
               	jmp	<addr>

<check_alignr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
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
               	leaq	-0x50(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x50(%rbp), %xmm0
               	movups	-0x40(%rbp), %xmm1
               	palignr	$0x0, %xmm1, %xmm0      # xmm0 = xmm1[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x1, %xmm1, %xmm0      # xmm0 = xmm1[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],xmm0[0]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x5, %xmm1, %xmm0      # xmm0 = xmm1[5,6,7,8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x8, %xmm1, %xmm0      # xmm0 = xmm1[8,9,10,11,12,13,14,15],xmm0[0,1,2,3,4,5,6,7]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0xf, %xmm1, %xmm0      # xmm0 = xmm1[15],xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x10, %xmm1, %xmm0     # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x11, %xmm1, %xmm0     # xmm0 = xmm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x18, %xmm1, %xmm0     # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
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
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x1f, %xmm1, %xmm0     # xmm0 = xmm0[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
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
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x20, %xmm1, %xmm0     # xmm0 = xmm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
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
               	movl	$0x20, %r13d
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rdx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x30(%rbp), %xmm0
               	movups	-0x50(%rbp), %xmm1
               	palignr	$0x28, %xmm1, %xmm0     # xmm0 = xmm0[8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7]
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
               	subq	$0xa0, %rsp
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
               	leaq	-0xa0(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0xa0(%rbp), %xmm0
               	pabsb	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x70(%rbp), %rax
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x90(%rbp), %xmm0
               	pabsw	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	-0x80(%rbp), %xmm0
               	pabsd	%xmm0, %xmm0
               	leaq	-0x30(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	leaq	-0x70(%rbp), %rax
               	movups	%xmm0, -0x70(%rbp)
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
