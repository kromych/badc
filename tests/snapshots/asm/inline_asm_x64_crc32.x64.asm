
inline_asm_x64_crc32.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cpuid
               	movl	%eax, -0x20(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	shrq	$0x14, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0xa5, %esi
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0xa5, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	crc32b	<rip>, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movl	$0xa5, %esi
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0x1234, %esi           # imm = 0x1234
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x1234, %ebx           # imm = 0x1234
               	crc32w	%bx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	crc32l	%ebx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	crc32q	%rbx, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	crc32q	<rip>, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0xa5, %esi
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0xa5, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0x1234, %esi           # imm = 0x1234
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x1234, %ebx           # imm = 0x1234
               	crc32w	%bx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	crc32l	%ebx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	crc32q	%rbx, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x10(%rbp)
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %r8
               	andq	$0x1, %r8
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r9
               	shrq	%r9
               	movl	%r8d, %r8d
               	xorq	%r8, %rdx
               	andq	$0x1, %rdx
               	imulq	%rdi, %rdx
               	movl	%edx, %edx
               	xorq	%r9, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x44, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x33, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x22, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x11, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %edx
               	movq	%rcx, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x11223344, %ebx       # imm = 0x11223344
               	crc32l	%ebx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
