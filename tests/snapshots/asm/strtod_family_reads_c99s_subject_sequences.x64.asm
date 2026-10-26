
strtod_family_reads_c99s_subject_sequences.x64:	file format elf64-x86-64

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

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movsd	%xmm0, -0x30(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rbx
               	jne	<addr>
               	movsd	-0x30(%rbp), %xmm0
               	ucomisd	%xmm0, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	%rbx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rbx), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%r12d, %r12d
               	movl	0x8(%rbx), %r13d
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x0, (%rax)
               	testl	%r12d, %r12d
               	jne	<addr>
               	movq	(%rbx), %rdi
               	leaq	-0x88(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	-0x88(%rbp), %r13
               	movq	(%rbx), %rax
               	subq	%rax, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	0x10(%rbx), %rdi
               	movsd	0x28(%rsp), %xmm0
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	0x8(%rbx), %eax
               	cmpl	%eax, %r13d
               	jne	<addr>
               	cmpl	$0x2, %r12d
               	jge	<addr>
               	movl	0x18(%rbx), %eax
               	testl	%eax, %eax
               	jl	<addr>
               	movl	0x18(%rbx), %eax
               	cmpl	%eax, %r14d
               	je	<addr>
               	jmp	<addr>
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	movq	-0x90(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	leaq	(%rax,%rcx), %r13
               	sarq	$0x2, %r13
               	jmp	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x28(%rsp)
               	jmp	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	0x1(%r12), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<floats>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3f800001, %eax       # imm = 0x3F800001
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x7fe1ccf385ebc8a0, %rax # imm = 0x7FE1CCF385EBC8A0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x7f7fffff, %eax       # imm = 0x7F7FFFFF
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x7fe1ccf385ebc8a0, %rax # imm = 0x7FE1CCF385EBC8A0
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x800000, %eax         # imm = 0x800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	fstpt	-0x20(%rbp)
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x4020000000000000, %rax # imm = 0x4020000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<comma>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2e, %eax
               	je	<addr>
               	movl	$0x2, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x24, %ebx
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0xc8, %rax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0xdc, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	shlq	$0x2, %rbx
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
