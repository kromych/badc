
perf_loop_shapes.x64:	file format elf64-x86-64

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

<count_zero>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	cmpb	$0x0, (%rdi,%rax)
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<partition>:
               	xorl	%ecx, %ecx
               	movl	$0x8, %eax
               	jmp	<addr>
               	incq	%rcx
               	movslq	%ecx, %rsi
               	movslq	(%rdi,%rsi,4), %rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	movslq	%eax, %rdx
               	movslq	(%rdi,%rdx,4), %r8
               	cmpl	$0x4, %r8d
               	jle	<addr>
               	decq	%rax
               	movslq	%eax, %rdx
               	movslq	(%rdi,%rdx,4), %r8
               	cmpl	$0x4, %r8d
               	jg	<addr>
               	cmpl	%eax, %ecx
               	jg	<addr>
               	movslq	(%rdi,%rsi,4), %r8
               	movslq	(%rdi,%rdx,4), %r9
               	movl	%r9d, (%rdi,%rsi,4)
               	movl	%r8d, (%rdi,%rdx,4)
               	incq	%rcx
               	decq	%rax
               	cmpl	%eax, %ecx
               	jle	<addr>
               	retq

<fib>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%edi, %rbx
               	xorl	%r12d, %r12d
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	subq	$0x2, %rbx
               	addq	%rax, %r12
               	cmpl	$0x2, %ebx
               	jge	<addr>
               	leaq	(%r12,%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<digit_power_sums>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r13
               	pushq	%r12
               	movq	%rsi, %r13
               	xorl	%edx, %edx
               	leaq	<rip>, %rdi
               	movq	%rdx, %r12
               	xorl	%ecx, %ecx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %r8  # imm = 0x1999999A
               	movq	%r8, %r9
               	shrq	$0x20, %r9
               	imulq	$0xa, %r9, %rsi
               	negq	%rsi
               	addq	%rax, %rsi
               	movslq	(%rdi,%rsi,4), %rsi
               	addq	%rsi, %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	movq	%r9, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%r12
               	movq	(%r13), %rax
               	addq	%rdx, %rax
               	movq	%rax, (%r13)
               	incq	%rdx
               	cmpl	$0xfa0, %edx            # imm = 0xFA0
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%r12
               	popq	%r13
               	popq	%rbp
               	retq

<lcg>:
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	cmpl	%esi, %eax
               	jge	<addr>
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movl	%ecx, %eax
               	retq

<lcg_wide>:
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<sieve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %ecx
               	movslq	%ecx, %rax
               	cmpb	$0x0, (%rdi,%rax)
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jge	<addr>
               	movslq	%eax, %rdx
               	movb	$0x1, (%rdi,%rdx)
               	addq	%rcx, %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	incq	%rcx
               	movslq	%ecx, %rax
               	movq	%rax, %rdx
               	imulq	%rax, %rdx
               	cmpq	$0x3e8, %rdx            # imm = 0x3E8
               	jl	<addr>
               	addq	$0x2, %rdi
               	movl	$0x3e6, %esi            # imm = 0x3E6
               	popq	%rbp
               	jmp	<addr>

<tenth>:
               	movslq	%edi, %rdi
               	imulq	$0x66666667, %rdi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	retq

<last_digit>:
               	movslq	%edi, %rdi
               	imulq	$0x66666667, %rdi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	imulq	$0xa, %rax, %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	retq

<mid>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	retq

<both>:
               	cmpl	$0x3, %edi
               	jge	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<square_at>:
               	movslq	%esi, %rsi
               	movslq	(%rdi,%rsi,4), %rax
               	imulq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movzbq	0x20(%rax), %rcx
               	movb	%cl, 0x20(%rdi)
               	movzbq	0x21(%rax), %rcx
               	movb	%cl, 0x21(%rdi)
               	movzbq	0x22(%rax), %rcx
               	movb	%cl, 0x22(%rdi)
               	movzbq	0x23(%rax), %rcx
               	movb	%cl, 0x23(%rdi)
               	popq	%rcx
               	xorl	%ebx, %ebx
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax,%rbx,4), %rax
               	cmpl	$0x4, %eax
               	jg	<addr>
               	incq	%rbx
               	cmpl	$0x9, %ebx
               	jl	<addr>
               	cmpl	$0x9, %ebx
               	jge	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax,%rbx,4), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x9, %ebx
               	jl	<addr>
               	movl	$0xf, %edi
               	callq	<addr>
               	cmpq	$0x262, %rax            # imm = 0x262
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movl	$0xfa0, %edi            # imm = 0xFA0
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xd6c, %rax            # imm = 0xD6C
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3039, %edi           # imm = 0x3039
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x3039, %rax           # imm = 0x3039
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3039, %ebx           # imm = 0x3039
               	movl	$0x3e8, %r12d           # imm = 0x3E8
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	cmpq	$0xa8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x25, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpq	$-0xccccccc, %rax       # imm = 0xF3333334
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x25, %rdi
               	callq	<addr>
               	cmpq	$-0x7, %rax
               	jne	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x3, %rdi
               	movq	$-0x4, %rsi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x30(%rbp), %rdi
               	movslq	(%rdi), %rax
               	imulq	%rax, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x8, %esi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	-0x30(%rbp), %rax
               	movslq	0x20(%rax), %rcx
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
