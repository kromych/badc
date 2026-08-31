
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
               	subq	$0x80, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	movq	%rax, -0x80(%rbp)
               	movq	%rcx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
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
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	movq	-0x70(%rbp), %rdx
               	movq	-0x68(%rbp), %rbx
               	movl	-0x10(%rbp), %eax
               	shrq	$0x14, %rax
               	andq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xa5, %esi
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	<rip>, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movl	$0xa5, %esi
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x1234, %esi           # imm = 0x1234
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32w	%bx, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32l	%ebx, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x68(%rbp), %rbx
               	crc32q	%rbx, %rax
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rcx
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x68(%rbp), %rbx
               	crc32q	<rip>, %rax
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xa5, %esi
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x1234, %esi           # imm = 0x1234
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32w	%bx, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rsi, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32l	%ebx, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %r9d
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movq	(%r10), %rax
               	movq	-0x68(%rbp), %rbx
               	crc32q	%rbx, %rax
               	movq	-0x70(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rax, -0x10(%rbp)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	movq	%rdx, %rdi
               	andq	$0x1, %rdi
               	movl	-0x10(%rbp), %edx
               	movq	%rdx, %r8
               	shrq	%r8
               	movl	%edi, %edi
               	xorq	%rdi, %rdx
               	andq	$0x1, %rdx
               	movl	$0x82f63b78, %r11d      # imm = 0x82F63B78
               	imulq	%r11, %rdx
               	movl	%edx, %edx
               	xorq	%r8, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x44, %edx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %ecx
               	movl	%ecx, %ecx
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x33, %edx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %ecx
               	movl	%ecx, %ecx
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x22, %edx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %ecx
               	movl	%ecx, %ecx
               	movq	%rcx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movl	$0x11, %edx
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rcx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32b	%bl, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %ecx
               	movl	%ecx, %ecx
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x11223344, %edx       # imm = 0x11223344
               	movq	%rax, -0x80(%rbp)
               	movq	%rbx, -0x78(%rbp)
               	movq	%rax, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	-0x70(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x68(%rbp), %rbx
               	crc32l	%ebx, %eax
               	movq	-0x70(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rbx
               	movl	-0x20(%rbp), %eax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
