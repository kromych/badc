
straight_line_block_merge.x64:	file format elf64-x86-64

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

<note>:
               	movslq	%edi, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movl	%edx, (%rcx)
               	retq

<both>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	cmpl	$0x3, %edi
               	jge	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	callq	<addr>
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rax
               	popq	%rbp
               	retq

<either>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	movq	%rsi, %rdi
               	callq	<addr>
               	addq	$0xc8, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movq	$-0x2, %rax
               	popq	%rbp
               	retq

<pick>:
               	movslq	%edi, %rdi
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>

<carry>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	movslq	%eax, %rbx
               	cmpl	$0x3, %edi
               	jge	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	movq	%rsi, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x5, %edi
               	jg	<addr>
               	cmpl	$0x9, %esi
               	jle	<addr>
               	movq	%rbx, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<tally>:
               	movq	%rdi, %r9
               	xorl	%edx, %edx
               	movq	%rdx, %r8
               	cmpl	%r9d, %edx
               	jge	<addr>
               	xorl	%eax, %eax
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jle	<addr>
               	imulq	$0x1999999a, %rcx, %rsi # imm = 0x1999999A
               	shrq	$0x20, %rsi
               	imulq	$0xa, %rsi, %rdi
               	subq	%rdi, %rcx
               	addq	%rcx, %rax
               	cmpl	%edx, %eax
               	jg	<addr>
               	movq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	%edx, %eax
               	jne	<addr>
               	incq	%r8
               	incq	%rdx
               	cmpl	%r9d, %edx
               	jl	<addr>
               	movq	%r8, %rax
               	retq

<count_wanted>:
               	xorl	%eax, %eax
               	cmpl	%esi, %edi
               	jge	<addr>
               	cmpl	$0x1, %edi
               	jle	<addr>
               	cmpl	$0x9, %edi
               	jl	<addr>
               	cmpl	$0x64, %edi
               	jne	<addr>
               	incq	%rax
               	incq	%rdi
               	cmpl	%esi, %edi
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<route>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$0x3, %edx
               	jl	<addr>
               	cmpl	$0x4, %edx
               	jl	<addr>
               	cmpl	$0x5, %edx
               	jl	<addr>
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0x13, %eax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0xf, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jl	<addr>
               	cmpl	$0x2, %edx
               	jl	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>

<spin>:
               	xorl	%eax, %eax
               	addq	%rdi, %rax
               	decq	%rdi
               	testl	%edi, %edi
               	jg	<addr>
               	movslq	%eax, %rax
               	retq

<scan>:
               	movq	%rcx, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	%edx, %r9d
               	jl	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	%r8d, %r9d
               	jg	<addr>
               	incq	%rcx
               	jmp	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	$-0x1, %r9d
               	je	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	$0x63, %r9d
               	je	<addr>
               	addq	$0x64, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<ladder>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	%edi, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0x1, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	%eax, %rax
               	leave
               	retq

<fork_at>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	testl	%edi, %edi
               	je	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	jmpq	*%rax
               	movl	$0xf, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	movslq	%eax, %rax
               	leave
               	retq

<lift>:
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	retq

<liftf>:
               	movl	$0x3f400000, %eax       # imm = 0x3F400000
               	movl	$0x3f400000, %r11d      # imm = 0x3F400000
               	movq	%r11, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addss	%xmm15, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	movq	%r13, %rbx
               	movl	$0x4, %r12d
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpl	$0x3, %r13d
               	setl	%al
               	movzbq	%al, %rax
               	cmpl	$0x7, %r12d
               	setl	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	leaq	0x64(%r13), %rdx
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	cmpl	$0x3, %r13d
               	setl	%al
               	movzbq	%al, %rax
               	cmpl	$0x7, %r12d
               	setl	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rax
               	leaq	0xc8(%r12), %rdx
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	andq	$-0x2, %rax
               	orq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	(%r13,%r13,2), %rax
               	incq	%rax
               	cmpl	$0x3, %r13d
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x7, %r12d
               	setl	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	leaq	(%rax,%r12), %rdx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	andq	%rcx, %rdx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	orq	%rdx, %rax
               	movslq	%eax, %r14
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	%r14, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	incq	%r12
               	cmpl	$0xa, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x6, %r13d
               	jl	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x7, %edi
               	movl	$0xc, %esi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	movq	%rax, %r13
               	andq	$0x4, %r13
               	movq	%rax, %r14
               	andq	$0x2, %r14
               	movq	%rax, %r12
               	andq	$0x1, %r12
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%r14d, %r14d
               	setne	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	xorq	$-0x1, %rax
               	andq	$0x2, %rax
               	orq	%rax, %rdx
               	testl	%r12d, %r12d
               	setne	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	movq	%rax, %rsi
               	andq	$0x3, %rsi
               	xorq	$-0x1, %rax
               	andq	$0x4, %rax
               	orq	%rax, %rsi
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	andq	%rsi, %rax
               	orq	%rdx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %ebx
               	movq	$-0x1, %r12
               	testl	%r12d, %r12d
               	setge	%al
               	movzbq	%al, %rax
               	cmpl	$0x5, %r12d
               	setle	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	leaq	0xa(%r12), %rcx
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	imulq	$-0x1, %rax, %rax
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	andq	$0x13, %rax
               	movq	%rcx, %r15
               	orq	%rax, %r15
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	testl	%r13d, %r13d
               	setne	%cl
               	movzbq	%cl, %rcx
               	testl	%r14d, %r14d
               	setne	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	andq	%r15, %rcx
               	addq	%r13, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %ebx
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	movq	0x38(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x9, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x13, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rsi
               	subq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0xa, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x13, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rsi
               	subq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x9, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x5b, %ecx
               	xorl	%eax, %eax
               	imulq	$0x1999999a, %rcx, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	imulq	$0xa, %rdx, %rsi
               	subq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0xa, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	$-0x5, %rdi
               	movl	$0xc8, %esi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x9, %edi
               	movl	$0x64, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x64, %edi
               	movl	$0x65, %esi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	$-0x3, %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0xe, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	movl	$0x3, %edx
               	movq	%rsi, %rcx
               	callq	<addr>
               	cmpq	$0xcb, %rax
               	je	<addr>
               	movl	$0xf, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	xorl	%edx, %edx
               	movl	$0x64, %ecx
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x10, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movl	$0x64, %ecx
               	movq	%rsi, %rdx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x12, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x13, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x3ffc000000000000, %rax # imm = 0x3FFC000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x14, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movl	$0x3fa00000, %eax       # imm = 0x3FA00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x15, %ebx
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	$0x3, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	leaq	0x4(%rax), %rsi
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	andq	%rcx, %rsi
               	addq	%rsi, %rdx
               	addq	$0x4, %rdx
               	leaq	0x5(%rax), %rsi
               	andq	%rcx, %rsi
               	addq	%rsi, %rdx
               	addq	$0x5, %rdx
               	leaq	0x6(%rax), %rsi
               	andq	%rsi, %rcx
               	addq	%rdx, %rcx
               	leaq	0x6(%rcx), %rdx
               	cmpl	$0x3, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, %rsi
               	andq	$0x7, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, %rsi
               	andq	$0x8, %rsi
               	addq	%rsi, %rdx
               	andq	$0x9, %rcx
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	%edx, %eax
               	je	<addr>
               	movl	$0x16, %ebx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
