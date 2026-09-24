
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
               	xorl	%eax, %eax
               	movl	$0x8, %ecx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rdx
               	movslq	(%rdi,%rdx,4), %rsi
               	cmpl	$0x4, %esi
               	jl	<addr>
               	movslq	%ecx, %rsi
               	movslq	(%rdi,%rsi,4), %r8
               	cmpl	$0x4, %r8d
               	jle	<addr>
               	decq	%rcx
               	movslq	%ecx, %rsi
               	movslq	(%rdi,%rsi,4), %r8
               	cmpl	$0x4, %r8d
               	jg	<addr>
               	cmpl	%ecx, %eax
               	jg	<addr>
               	movslq	(%rdi,%rdx,4), %r8
               	movslq	(%rdi,%rsi,4), %r9
               	movl	%r9d, (%rdi,%rdx,4)
               	movl	%r8d, (%rdi,%rsi,4)
               	incq	%rax
               	decq	%rcx
               	cmpl	%ecx, %eax
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rsi, %rbx
               	xorl	%edx, %edx
               	leaq	<rip>, %r8
               	movq	%rdx, %rsi
               	xorl	%ecx, %ecx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdi # imm = 0x1999999A
               	shrq	$0x20, %rdi
               	imulq	$0xa, %rdi, %r9
               	subq	%r9, %rax
               	movslq	(%r8,%rax,4), %r9
               	addq	%r9, %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rsi
               	movq	(%rbx), %rax
               	addq	%rdx, %rax
               	movq	%rax, (%rbx)
               	incq	%rdx
               	cmpl	$0xfa0, %edx            # imm = 0xFA0
               	jl	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	leave
               	retq

<lcg>:
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorl	%ecx, %ecx
               	cmpl	%esi, %ecx
               	jge	<addr>
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	addq	$0x3039, %rax           # imm = 0x3039
               	incq	%rcx
               	cmpl	%esi, %ecx
               	jl	<addr>
               	retq

<lcg_wide>:
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorl	%ecx, %ecx
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %eax
               	incq	%rcx
               	cmpl	$0x3e8, %ecx            # imm = 0x3E8
               	jl	<addr>
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

<negi>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<negl>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<negu>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<negneg>:
               	movq	%rdi, %rax
               	negq	%rax
               	negq	%rax
               	retq

<sub_of_neg>:
               	movl	$0x7, %eax
               	retq

<add_of_neg>:
               	movq	$-0x1, %rax
               	retq

<neg_minus_one>:
               	movq	%rdi, %rax
               	xorq	$-0x1, %rax
               	retq

<zero_minus>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<times_minus_one>:
               	movq	%rdi, %rax
               	negq	%rax
               	retq

<pos>:
               	movq	%rdi, %rax
               	retq

<guarded_negate>:
               	testq	%rdi, %rdi
               	setg	%cl
               	movzbq	%cl, %rcx
               	movq	%rsi, %rax
               	negq	%rax
               	testq	%rcx, %rcx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rbx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movl	0x20(%rax), %r10d
               	movl	%r10d, 0x20(%rbx)
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	cmpl	$0x4, %ecx
               	jg	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	cmpl	$0x9, %eax
               	jge	<addr>
               	movslq	(%rbx,%rax,4), %rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	incq	%rax
               	cmpl	$0x9, %eax
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
               	leave
               	retq
               	movl	$0x3039, %edi           # imm = 0x3039
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x3039, %eax           # imm = 0x3039
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3039, %edi           # imm = 0x3039
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x3039, %edi           # imm = 0x3039
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	cmpq	$0xa8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x25, %rdi
               	callq	<addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpl	$0xf3333334, %eax       # imm = 0xF3333334
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x25, %rdi
               	callq	<addr>
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x3, %rdi
               	movq	$-0x4, %rsi
               	callq	<addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movq	$-0x1, %rsi
               	callq	<addr>
               	cmpl	$0x3fffffff, %eax       # imm = 0x3FFFFFFF
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x2, %edi
               	movl	$0x7, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	-0x30(%rbp), %rdi
               	movslq	(%rdi), %rcx
               	imulq	%rcx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x8, %esi
               	callq	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movslq	0x20(%rcx), %rcx
               	imulq	%rcx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	movq	$-0x7, %rdi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$-0x7, %rax
               	jne	<addr>
               	movq	$-0x7, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	callq	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$-0x6, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$-0x5, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x7, %rdi
               	callq	<addr>
               	cmpl	$-0x7, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	$-0x5, %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x9, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
