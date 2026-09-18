
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
               	movq	%rsi, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<partition>:
               	xorq	%rax, %rax
               	movl	$0x8, %ecx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	movslq	(%rdi,%rsi,4), %rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	jmp	<addr>
               	leaq	-0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	movslq	(%rdi,%rdx,4), %r8
               	cmpl	$0x4, %r8d
               	jg	<addr>
               	cmpl	%ecx, %eax
               	jg	<addr>
               	movslq	(%rdi,%rsi,4), %r8
               	movslq	(%rdi,%rdx,4), %r9
               	movl	%r9d, (%rdi,%rsi,4)
               	movl	%r8d, (%rdi,%rdx,4)
               	incq	%rax
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	cmpl	%ecx, %eax
               	jle	<addr>
               	retq

<fib>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	xorq	%r12, %r12
               	jmp	<addr>
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	-0x2(%rbx), %rax
               	movslq	%eax, %rbx
               	addq	%rcx, %r12
               	cmpq	$0x2, %rbx
               	jge	<addr>
               	leaq	(%r12,%rbx), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<digit_power_sums>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%rsi, %r13
               	xorq	%rdx, %rdx
               	movq	%rdx, %r12
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	imulq	$0x66666667, %rsi, %rdi # imm = 0x66666667
               	movq	%rdi, %r8
               	sarq	$0x22, %r8
               	movq	%r8, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %r8
               	imulq	$0xa, %r8, %r8
               	movq	%rsi, %r9
               	subq	%r8, %r9
               	leaq	<rip>, %r8
               	movslq	%r9d, %r9
               	movslq	(%r8,%r9,4), %r8
               	addq	%r8, %rax
               	cmpl	%edx, %eax
               	jg	<addr>
               	movq	%rdi, %rcx
               	sarq	$0x22, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	%edx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	incq	%r12
               	movq	(%r13), %rax
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, (%r13)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0xfa0, %edx            # imm = 0xFA0
               	jl	<addr>
               	movq	%r12, %rax
               	movq	(%rsp), %r12
               	movq	0x8(%rsp), %r13
               	leave
               	retq

<lcg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	-0x20(%rbp), %ecx
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	movl	%ecx, -0x20(%rbp)
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movl	-0x20(%rbp), %eax
               	leave
               	retq

<lcg_wide>:
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<sieve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %ecx
               	jmp	<addr>
               	leaq	(%rdi,%r8), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	addq	%rdi, %rdx
               	movl	$0x1, %esi
               	movb	%sil, (%rdx)
               	addq	%rcx, %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jl	<addr>
               	leaq	0x1(%r8), %rcx
               	movslq	%ecx, %r8
               	movq	%r8, %rax
               	imulq	%r8, %rax
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	jl	<addr>
               	addq	$0x2, %rdi
               	movl	$0x3e6, %esi            # imm = 0x3E6
               	popq	%rbp
               	jmp	<addr>

<tenth>:
               	movslq	%edi, %rdi
               	movl	$0xa, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	popq	%rdx
               	movslq	%eax, %rax
               	retq

<last_digit>:
               	movslq	%edi, %rdi
               	movl	$0xa, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movslq	%eax, %rax
               	retq

<mid>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movslq	%eax, %rax
               	retq

<both>:
               	cmpl	$0x3, %edi
               	jge	<addr>
               	cmpl	$0x7, %esi
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<square_at>:
               	movslq	%esi, %rsi
               	movslq	(%rdi,%rsi,4), %rax
               	movslq	(%rdi,%rsi,4), %rcx
               	imulq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	xorq	%rsi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	xorq	%rbx, %rbx
               	movl	$0x8, %edx
               	movl	$0x4, %ecx
               	movq	%rbx, %rsi
               	callq	<addr>
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rcx
               	movslq	%ebx, %rax
               	movslq	(%rcx,%rax,4), %rcx
               	cmpl	$0x4, %ecx
               	setle	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x1(%rax), %rbx
               	cmpl	$0x9, %ebx
               	jl	<addr>
               	movslq	%ebx, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rdx
               	movslq	%eax, %rcx
               	movslq	(%rdx,%rcx,4), %rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x9, %eax
               	jl	<addr>
               	movl	$0xf, %edi
               	callq	<addr>
               	cmpq	$0x262, %rax            # imm = 0x262
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	$0xfa0, %edi            # imm = 0xFA0
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xd6c, %rax            # imm = 0xD6C
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3039, %edi           # imm = 0x3039
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpq	$0x3039, %rax           # imm = 0x3039
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	cmpq	$0xa8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x25, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x80000000, %rdi      # imm = 0x80000000
               	callq	<addr>
               	cmpq	$-0xccccccc, %rax       # imm = 0xF3333334
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x25, %rdi
               	callq	<addr>
               	cmpq	$-0x7, %rax
               	jne	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movabsq	$-0x3, %rdi
               	movabsq	$-0x4, %rsi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movabsq	$-0x1, %rsi
               	callq	<addr>
               	cmpq	$0x3fffffff, %rax       # imm = 0x3FFFFFFF
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x6, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorq	%rsi, %rsi
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
