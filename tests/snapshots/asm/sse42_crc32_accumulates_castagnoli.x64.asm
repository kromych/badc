
sse42_crc32_accumulates_castagnoli.x64:	file format elf64-x86-64

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

<reference>:
               	xorl	%ecx, %ecx
               	movl	$0x82f63b78, %eax       # imm = 0x82F63B78
               	cmpl	%edx, %ecx
               	jge	<addr>
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rsi, %r8
               	andq	$0xff, %r8
               	xorq	%rdi, %r8
               	movl	%r8d, %edi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	movq	%rdi, %r8
               	shrq	%r8
               	andq	$0x1, %rdi
               	negq	%rdi
               	andq	%rax, %rdi
               	xorq	%r8, %rdi
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movq	%rcx, %rax
               	movl	$0x31, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x32, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x33, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x34, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x35, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x36, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x37, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x38, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x39, %r10d
               	crc32b	%r10b, %eax
               	movzwq	-0x18(%rbp), %rdx
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	crc32w	%dx, %esi
               	movzwq	-0x16(%rbp), %rdx
               	movl	%esi, %esi
               	crc32w	%dx, %esi
               	movzwq	-0x14(%rbp), %rdx
               	movl	%esi, %esi
               	crc32w	%dx, %esi
               	movzwq	-0x12(%rbp), %rdx
               	movl	%esi, %esi
               	crc32w	%dx, %esi
               	movl	-0x10(%rbp), %edx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	crc32l	%edx, %edi
               	movl	-0xc(%rbp), %edx
               	movl	%edi, %edi
               	crc32l	%edx, %edi
               	movq	-0x8(%rbp), %rdx
               	crc32q	%rdx, %rcx
               	movl	%esi, %edx
               	movl	$0x39, %r10d
               	crc32b	%r10b, %edx
               	movl	%edi, %esi
               	movl	$0x39, %r10d
               	crc32b	%r10b, %esi
               	movl	%ecx, %ecx
               	movl	$0x39, %r10d
               	crc32b	%r10b, %ecx
               	xorq	$-0x1, %rax
               	cmpl	$0xe3069283, %eax       # imm = 0xE3069283
               	jne	<addr>
               	xorq	$-0x1, %rdx
               	cmpl	$0xe3069283, %edx       # imm = 0xE3069283
               	jne	<addr>
               	xorq	$-0x1, %rsi
               	cmpl	$0xe3069283, %esi       # imm = 0xE3069283
               	je	<addr>
               	movl	$0x2f, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	cmpl	$0xe3069283, %eax       # imm = 0xE3069283
               	je	<addr>
               	movl	$0x30, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movabsq	$-0x61c8864680b583eb, %rbx # imm = 0x9E3779B97F4A7C15
               	xorl	%r13d, %r13d
               	movq	%r13, %r12
               	movabsq	$0x5851f42d4c957f2d, %rax # imm = 0x5851F42D4C957F2D
               	imulq	%rbx, %rax
               	movabsq	$0x14057b7ef767814f, %rbx # imm = 0x14057B7EF767814F
               	addq	%rax, %rbx
               	movq	%r12, %r14
               	crc32q	%rbx, %r14
               	movl	$0x8, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movl	%ebx, %eax
               	movq	%r12, %r14
               	crc32l	%eax, %r14d
               	movl	$0x4, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpl	%eax, %r14d
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%r12, %r14
               	crc32w	%ax, %r14d
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpl	%eax, %r14d
               	jne	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movq	%r12, %r14
               	crc32b	%al, %r14d
               	movl	$0x1, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpl	%eax, %r14d
               	jne	<addr>
               	movq	%rbx, %r12
               	shrq	$0x20, %r12
               	incq	%r13
               	cmpl	$0xc8, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x38, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x37, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x36, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x35, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
