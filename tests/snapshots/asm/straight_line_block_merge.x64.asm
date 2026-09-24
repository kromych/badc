
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
               	movq	%rdi, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	addq	%rax, %rdx
               	movl	%edx, (%rcx)
               	retq

<both>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x3, %edi
               	jge	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	callq	<addr>
               	addq	$0x64, %rax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rax
               	popq	%rbp
               	retq

<either>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	movq	%rsi, %rdi
               	callq	<addr>
               	addq	$0xc8, %rax
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
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	0x1(%rax), %rbx
               	cmpl	$0x3, %edi
               	jge	<addr>
               	cmpl	$0x7, %esi
               	jge	<addr>
               	movq	%rsi, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	cmpl	$0x5, %edi
               	jg	<addr>
               	cmpl	$0x9, %esi
               	jle	<addr>
               	movq	%rbx, %rax
               	subq	%rsi, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<tally>:
               	testl	%edi, %edi
               	jle	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%edx, %edx
               	movq	%rdx, %rdi
               	xorl	%ecx, %ecx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rsi # imm = 0x1999999A
               	shrq	$0x20, %rsi
               	imulq	$0xa, %rsi, %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	addq	%r9, %rcx
               	cmpl	%edx, %ecx
               	jg	<addr>
               	movq	%rsi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rdi
               	incq	%rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	movq	%rdi, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
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
               	retq

<scan>:
               	xorl	%eax, %eax
               	movq	%rax, %r8
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	%edx, %r9d
               	jl	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	%ecx, %r9d
               	jg	<addr>
               	incq	%r8
               	jmp	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	$-0x1, %r9d
               	je	<addr>
               	movslq	(%rdi,%rax,4), %r9
               	cmpl	$0x63, %r9d
               	je	<addr>
               	addq	$0x64, %r8
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%r8, %rax
               	retq

<ladder>:
               	movslq	%edi, %rdi
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rdi,8), %rcx
               	jmpq	*%rcx
               	movl	$0x1, %eax
               	addq	$0x2, %rax
               	addq	$0x4, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>

<fork_at>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rax         # <addr>
               	movl	$0x5, %ecx
               	jmpq	*%rax
               	movl	$0xf, %ecx
               	leaq	0x1(%rcx), %rax
               	retq
               	jmp	<addr>
               	leaq	-<rip>, %rax        # <addr>
               	jmp	<addr>

<lift>:
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	retq

<liftf>:
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
               	cmpl	$0x3, %r13d
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x7, %r12d
               	setl	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	leaq	0x64(%r13), %rdx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	andq	%rcx, %rdx
               	xorq	$-0x1, %rcx
               	orq	%rdx, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpl	$0x3, %r13d
               	setl	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x7, %r12d
               	setl	%dl
               	movzbq	%dl, %rdx
               	orq	%rdx, %rcx
               	leaq	0xc8(%r12), %rdx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	andq	%rcx, %rdx
               	xorq	$-0x1, %rcx
               	andq	$-0x2, %rcx
               	orq	%rdx, %rcx
               	cmpl	%ecx, %eax
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
               	negq	%rcx
               	andq	%rcx, %rdx
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rdx, %r14
               	orq	%rax, %r14
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpl	%r14d, %eax
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
               	cmpl	$0xa, %eax
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
               	testl	%r14d, %r14d
               	setne	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	xorq	$-0x1, %rcx
               	andq	$0x2, %rcx
               	orq	%rcx, %rdx
               	testl	%r12d, %r12d
               	setne	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	andq	$0x3, %rsi
               	xorq	$-0x1, %rcx
               	andq	$0x4, %rcx
               	orq	%rcx, %rsi
               	testl	%r13d, %r13d
               	setne	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	andq	%rcx, %rdx
               	xorq	$-0x1, %rcx
               	andq	%rsi, %rcx
               	orq	%rdx, %rcx
               	cmpl	%ecx, %eax
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
               	negq	%rax
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
               	negq	%rcx
               	andq	%r15, %rcx
               	addq	%r13, %rcx
               	cmpl	%ecx, %eax
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
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xb, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x9, %edi
               	movl	$0x64, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x64, %edi
               	movl	$0x65, %esi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xd, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movq	$-0x3, %rdi
               	callq	<addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0xe, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	movl	$0x3, %edx
               	movq	%rsi, %rcx
               	callq	<addr>
               	cmpl	$0xcb, %eax
               	je	<addr>
               	movl	$0xf, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7, %esi
               	xorl	%edx, %edx
               	movl	$0x64, %ecx
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x10, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movl	$0x64, %ecx
               	movq	%rsi, %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x11, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x12, %ebx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x10, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
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
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	setl	%dl
               	movzbq	%dl, %rdx
               	leaq	0x4(%rax), %rdi
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, %rsi
               	negq	%rsi
               	andq	%rsi, %rdi
               	addq	%rdi, %rcx
               	addq	$0x4, %rcx
               	leaq	0x5(%rax), %rdi
               	andq	%rdi, %rsi
               	addq	%rsi, %rcx
               	addq	$0x5, %rcx
               	leaq	0x6(%rax), %rsi
               	negq	%rdx
               	andq	%rsi, %rdx
               	addq	%rdx, %rcx
               	leaq	0x6(%rcx), %rdx
               	cmpl	$0x3, %eax
               	setl	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	%rcx, %rsi
               	andq	$0x7, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, %rsi
               	andq	$0x8, %rsi
               	addq	%rsi, %rdx
               	andq	$0x9, %rcx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x6, %eax
               	jl	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	%ecx, %eax
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
