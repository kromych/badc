
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
               	movl	$0xff800000, %eax       # imm = 0xFF800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
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
               	movl	$0x7f800000, %eax       # imm = 0x7F800000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x30(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	0x30(%rsp), %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %rbx
               	leaq	-0x88(%rbp), %rdi
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
               	leaq	-0x98(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movq	-0x98(%rbp), %r13
               	movq	(%rbx), %rax
               	subq	%rax, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	0x10(%rbx), %r14
               	movsd	0x38(%rsp), %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %r14
               	jne	<addr>
               	movsd	-0x8(%rbp), %xmm0
               	ucomisd	%xmm0, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
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
               	cmpl	%eax, %r15d
               	je	<addr>
               	jmp	<addr>
               	movq	-0x90(%rbp), %rax
               	cmpq	%r14, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x38(%rsp)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x88(%rbp), %rcx
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
               	movsd	%xmm0, 0x38(%rsp)
               	jmp	<addr>
               	incq	%r12
               	cmpl	$0x3, %r12d
               	jl	<addr>
               	xorl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	0x1(%r12), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x30(%rsp), %rax
               	cmpl	$0x24, %eax
               	jb	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0xc8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%ebx, %ebx
               	movl	$0x1, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0xdc(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2e, %eax
               	je	<addr>
               	movl	$0x2, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
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
               	movq	0x30(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
