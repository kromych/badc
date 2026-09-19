
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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%eax, -0x20(%rbp)
               	movl	%ebx, -0x18(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	-0x10(%rbp), %eax
               	shrq	$0x14, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa5, %esi
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0xa5, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	crc32b	<rip>, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xa5, %esi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1234, %esi           # imm = 0x1234
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0x1234, %ebx           # imm = 0x1234
               	crc32w	%bx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	crc32l	%ebx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	crc32q	%rbx, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	crc32q	<rip>, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa5, %esi
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0xa5, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1234, %esi           # imm = 0x1234
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0x1234, %ebx           # imm = 0x1234
               	crc32w	%bx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x10, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	crc32l	%ebx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %r9d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x20, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x20, %ecx
               	jl	<addr>
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movabsq	$0x123456789abcdef, %rbx # imm = 0x123456789ABCDEF
               	crc32q	%rbx, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	cmpl	$0x40, %ecx
               	jge	<addr>
               	movq	%rsi, %rdx
               	shrq	%cl, %rdx
               	andq	$0x1, %rdx
               	movl	%eax, %eax
               	movq	%rax, %r8
               	shrq	%r8
               	xorq	%rdx, %rax
               	andq	$0x1, %rax
               	imulq	%rdi, %rax
               	xorq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0x44, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x33, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x22, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	movl	$0x11, %ebx
               	crc32b	%bl, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %ecx
               	movl	$0xffffffff, -0x20(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x20(%rbp), %eax
               	movl	$0x11223344, %ebx       # imm = 0x11223344
               	crc32l	%ebx, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	-0x20(%rbp), %eax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
