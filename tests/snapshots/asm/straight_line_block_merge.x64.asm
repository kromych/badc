
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
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rcx
               	addq	%rax, %rcx
               	movl	%ecx, (%rdx)
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%edx, %edx
               	movq	%rdx, %r9
               	cmpl	%ebx, %edx
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rsi # imm = 0x1999999A
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	imulq	$0xa, %rdi, %r8
               	movq	%r8, %r10
               	movq	%rax, %r8
               	subq	%r10, %r8
               	addq	%r8, %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%r9
               	incq	%rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movq	%r9, %rax
               	popq	%rbx
               	leave
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
               	movslq	%edx, %rdx
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
               	testq	%rdx, %rdx
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
               	movslq	%edi, %rax
               	testq	%rax, %rax
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
               	cmpl	$0x6, %r13d
               	jge	<addr>
               	movl	$0x4, %r12d
               	cmpl	$0xa, %r12d
               	jge	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpl	$0x3, %r13d
               	setl	%al
               	movzbq	%al, %rax
               	cmpl	$0x7, %r12d
               	setl	%cl
               	movzbq	%cl, %rcx
               	andq	%rax, %rcx
               	leaq	0x64(%r13), %rdx
               	testl	%ecx, %ecx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	$-0x1, %rsi, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	orq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpl	$0x3, %r13d
               	setl	%al
               	movzbq	%al, %rax
               	cmpl	$0x7, %r12d
               	setl	%cl
               	movzbq	%cl, %rcx
               	orq	%rax, %rcx
               	leaq	0xc8(%r12), %rdx
               	testl	%ecx, %ecx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	$-0x1, %rsi, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	andq	$-0x2, %rax
               	orq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rdi
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
               	movq	%rax, %rsi
               	orq	$0x0, %rsi
               	testl	%ecx, %ecx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	$-0x1, %rdi, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	andq	%rsi, %rax
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
               	cmpl	$0x8, %eax
               	jge	<addr>
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
               	movq	%rax, %rdi
               	testl	%r14d, %r14d
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	$-0x1, %rcx, %rax
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	xorq	$-0x1, %rax
               	andq	$0x2, %rax
               	movq	%rdx, %rcx
               	orq	%rax, %rcx
               	testl	%r12d, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	imulq	$-0x1, %rdx, %rax
               	movq	%rax, %rsi
               	andq	$0x3, %rsi
               	xorq	$-0x1, %rax
               	andq	$0x4, %rax
               	movq	%rsi, %rdx
               	orq	%rax, %rdx
               	testl	%r13d, %r13d
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	$-0x1, %rsi, %rax
               	andq	%rax, %rcx
               	xorq	$-0x1, %rax
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x5, %ebx
               	movq	$-0x1, %r12
               	cmpl	$0x8, %r12d
               	jge	<addr>
               	testl	%r12d, %r12d
               	setge	%al
               	movzbq	%al, %rax
               	cmpl	$0x5, %r12d
               	setle	%cl
               	movzbq	%cl, %rcx
               	andq	%rax, %rcx
               	leaq	0xa(%r12), %rdx
               	testl	%ecx, %ecx
               	setne	%sil
               	movzbq	%sil, %rsi
               	imulq	$-0x1, %rsi, %rax
               	andq	%rax, %rdx
               	xorq	$-0x1, %rax
               	andq	$0x13, %rax
               	movq	%rdx, %r15
               	orq	%rax, %r15
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movq	%rax, %rdx
               	testl	%r13d, %r13d
               	setne	%al
               	movzbq	%al, %rax
               	testl	%r14d, %r14d
               	setne	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	andq	%r15, %rcx
               	movq	%rcx, %rax
               	orq	$0x0, %rax
               	addq	%r13, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x6, %ebx
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	movq	0x38(%rsp), %rax
               	leaq	0x1(%rax), %r10
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
               	movl	$0x13, %eax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	imulq	$0xa, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	addq	%rdi, %rcx
               	cmpl	$0xa, %ecx
               	jg	<addr>
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0xa, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x13, %eax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	imulq	$0xa, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	addq	%rdi, %rcx
               	cmpl	$0x9, %ecx
               	jg	<addr>
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x5b, %eax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	imulq	$0xa, %rsi, %rdi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	addq	%rdi, %rcx
               	cmpl	$0x1, %ecx
               	jg	<addr>
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x1, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
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
               	movq	%rax, %rsi
               	cmpl	$0x6, %eax
               	jge	<addr>
               	cmpl	$0x3, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	leaq	0x4(%rax), %rdi
               	testl	%ecx, %ecx
               	setne	%r8b
               	movzbq	%r8b, %r8
               	imulq	$-0x1, %r8, %rdx
               	movq	%rdx, %r9
               	andq	%rdi, %r9
               	movq	%r9, %rdi
               	orq	$0x0, %rdi
               	addq	%rdi, %rsi
               	leaq	0x4(%rsi), %rdi
               	leaq	0x5(%rax), %rsi
               	andq	%rdx, %rsi
               	movq	%rsi, %rdx
               	orq	$0x0, %rdx
               	addq	%rdi, %rdx
               	leaq	0x5(%rdx), %rsi
               	leaq	0x6(%rax), %rdx
               	testl	%ecx, %ecx
               	setne	%dil
               	movzbq	%dil, %rdi
               	imulq	$-0x1, %rdi, %rdi
               	andq	%rdi, %rdx
               	movq	%rdx, %rcx
               	orq	$0x0, %rcx
               	addq	%rsi, %rcx
               	addq	$0x6, %rcx
               	leaq	(%rcx), %r8
               	cmpl	$0x3, %eax
               	setl	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, %rcx
               	orq	$0x0, %rcx
               	testl	%ecx, %ecx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	imulq	$-0x1, %r9, %rdx
               	movq	%rdx, %r12
               	andq	$0x7, %r12
               	movq	%r12, %rdi
               	orq	$0x0, %rdi
               	addq	%r8, %rdi
               	addq	$0x0, %rdi
               	andq	$0x8, %rdx
               	movq	%rdx, %rcx
               	orq	$0x0, %rcx
               	addq	%rdi, %rcx
               	leaq	(%rcx), %rdi
               	movq	%rsi, %rcx
               	orq	$0x0, %rcx
               	testl	%ecx, %ecx
               	setne	%dl
               	movzbq	%dl, %rdx
               	imulq	$-0x1, %rdx, %rdx
               	andq	$0x9, %rdx
               	movq	%rdx, %rcx
               	orq	$0x0, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	%esi, %eax
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
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
