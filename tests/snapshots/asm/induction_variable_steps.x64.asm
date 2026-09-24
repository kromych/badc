
induction_variable_steps.x64:	file format elf64-x86-64

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

<scan>:
               	xorl	%eax, %eax
               	movslq	(%rdi,%rax,4), %rcx
               	cmpl	%esi, %ecx
               	jge	<addr>
               	incq	%rax
               	movslq	(%rdi,%rax,4), %rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	retq

<scan_down>:
               	movl	$0x3f, %eax
               	movslq	(%rdi,%rax,4), %rcx
               	cmpl	%edx, %ecx
               	jle	<addr>
               	decq	%rax
               	movslq	(%rdi,%rax,4), %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	retq

<stride>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %rdx
               	addq	%rdx, %rcx
               	addq	$0x3, %rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<stride_var>:
               	movslq	%edx, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %r8
               	addq	%r8, %rcx
               	addq	%rdx, %rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<triangle>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	movslq	(%rdi,%rax,4), %rsi
               	addq	%rsi, %rdx
               	incq	%rcx
               	addq	%rcx, %rax
               	cmpl	$0xb, %ecx
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<upto>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdi,%rax,4), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3e, %eax
               	jle	<addr>
               	movq	%rcx, %rax
               	retq

<cross_zero>:
               	movq	$-0x25, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rdx
               	imulq	%rcx, %rdx
               	movq	%rcx, %rsi
               	sarq	%rsi
               	movq	%rdx, %rdi
               	subq	%rsi, %rdi
               	imulq	$0x55555556, %rcx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x66666667, %rcx, %rdx # imm = 0x66666667
               	sarq	$0x21, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,4), %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	leaq	(%rsi,%rdi), %rdx
               	addq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x29, %ecx
               	jl	<addr>
               	retq

<square_bound>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	cmpq	%rsi, %rdx
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<two_steps>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	0x1(%rax), %rdx
               	movzbq	(%rdi,%rax), %rax
               	addq	%rax, %rcx
               	leaq	0x1(%rdx), %rax
               	movzbq	(%rdi,%rdx), %rdx
               	shlq	%rdx
               	subq	%rdx, %rcx
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<down3>:
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	leaq	-0x1(%rsi), %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	movslq	(%rdi,%rcx,4), %rdx
               	addq	%rdx, %rax
               	subq	$0x3, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	retq

<last_index>:
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %rcx
               	cmpl	%edx, %ecx
               	je	<addr>
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	retq

<hash>:
               	movl	$0x7, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1f, %rcx, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	imulq	$0x7, %rax, %rdx
               	subq	$0x32, %rdx
               	movl	%edx, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	imulq	$0xd, %rax, %rdx
               	addq	$0x5, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	movl	$0x40, -0x30(%rbp)
               	movl	$0x28, -0x28(%rbp)
               	movl	$0x5, -0x20(%rbp)
               	movl	$0xc8, -0x18(%rbp)
               	movl	$0xffffffd8, -0x10(%rbp) # imm = 0xFFFFFFD8
               	movq	$0x3e8, -0x8(%rbp)      # imm = 0x3E8
               	leaq	<rip>, %rdi
               	movslq	-0x18(%rbp), %rsi
               	callq	<addr>
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3f, %esi
               	movslq	-0x10(%rbp), %rdx
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movslq	-0x30(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0xea7, %rax            # imm = 0xEA7
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movslq	-0x30(%rbp), %rsi
               	movslq	-0x20(%rbp), %rdx
               	callq	<addr>
               	cmpq	$0x820, %rax            # imm = 0x820
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0xb, %esi
               	callq	<addr>
               	cmpq	$0x3de, %rax            # imm = 0x3DE
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3e, %esi
               	callq	<addr>
               	cmpq	$0x2919, %rax           # imm = 0x2919
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	$-0x25, %rdi
               	movl	$0x29, %esi
               	callq	<addr>
               	cmpq	$0x9b29, %rax           # imm = 0x9B29
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x750, %rax            # imm = 0x750
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movslq	-0x28(%rbp), %rsi
               	callq	<addr>
               	cmpq	$-0x9b8, %rax           # imm = 0xF648
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movslq	-0x30(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0xea7, %rax            # imm = 0xEA7
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movslq	-0x30(%rbp), %rsi
               	movl	$0x5a, %edx
               	callq	<addr>
               	cmpq	$0x14, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movslq	-0x30(%rbp), %rsi
               	movl	$0x5b, %edx
               	callq	<addr>
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0xc410a78, %rax        # imm = 0xC410A78
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
