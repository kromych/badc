
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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rdi, -0x40(%rbp)
               	movq	%r8, -0x38(%rbp)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	cpuid
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x58(%rbp), %r10
               	movl	%ebx, (%r10)
               	movq	-0x50(%rbp), %r10
               	movl	%ecx, (%r10)
               	movq	-0x48(%rbp), %r10
               	movl	%edx, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	leaq	<rip>, %rax
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	<rip>, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32w	%bx, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32l	%ebx, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x58(%rbp), %rbx
               	crc32q	%rbx, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
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
               	leaq	<rip>, %rax
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x58(%rbp), %rbx
               	crc32q	<rip>, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32w	%bx, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32l	%ebx, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rdx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x58(%rbp), %rbx
               	crc32q	%rbx, %rax
               	movq	-0x60(%rbp), %r10
               	movq	%rax, (%r10)
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
               	leaq	-0x20(%rbp), %rax
               	movl	$0x44, %edx
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x33, %edx
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x22, %edx
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %eax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x11, %edx
               	movq	%rax, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, %edx
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	crc32l	%ebx, %eax
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
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
