
inline_asm_x64_crc32.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	%ecx, %eax
               	shrq	$0x14, %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movl	$0xa5, %r10d
               	crc32b	%r10b, %r9d
               	movl	$0xa5, %esi
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	crc32b	<rip>, %eax # <addr>
               	movl	$0xa5, %edi
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %r8d       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	shrxq	%rcx, %rdi, %rdx
               	andq	$0x1, %rdx
               	movq	%rsi, %r9
               	shrq	%r9
               	xorq	%rsi, %rdx
               	andq	$0x1, %rdx
               	imulq	%r8, %rdx
               	movq	%r9, %rsi
               	xorq	%rdx, %rsi
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	cmpl	%esi, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movl	$0x1234, %r10d          # imm = 0x1234
               	crc32w	%r10w, %r9d
               	movl	$0x1234, %esi           # imm = 0x1234
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movl	$0xdeadbeef, %r10d      # imm = 0xDEADBEEF
               	crc32l	%r10d, %r9d
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movabsq	$0x123456789abcdef, %r10 # imm = 0x123456789ABCDEF
               	crc32q	%r10, %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	%rdx, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	crc32q	<rip>, %rax # <addr>
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %r8d       # imm = 0x82F63B78
               	xorl	%ecx, %ecx
               	shrxq	%rcx, %rdi, %rdx
               	andq	$0x1, %rdx
               	movq	%rsi, %r9
               	shrq	%r9
               	xorq	%rsi, %rdx
               	andq	$0x1, %rdx
               	imulq	%r8, %rdx
               	movq	%r9, %rsi
               	xorq	%rdx, %rsi
               	incq	%rcx
               	nop
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movl	$0xa5, %r10d
               	crc32b	%r10b, %r9d
               	movl	$0xa5, %esi
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movl	$0x1234, %r10d          # imm = 0x1234
               	crc32w	%r10w, %r9d
               	movl	$0x1234, %esi           # imm = 0x1234
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movl	$0xdeadbeef, %r10d      # imm = 0xDEADBEEF
               	crc32l	%r10d, %r9d
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x20, %eax
               	jl	<addr>
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %r9
               	movabsq	$0x123456789abcdef, %r10 # imm = 0x123456789ABCDEF
               	crc32q	%r10, %r9
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0x82f63b78, %edi       # imm = 0x82F63B78
               	xorl	%eax, %eax
               	shrxq	%rax, %rsi, %rcx
               	andq	$0x1, %rcx
               	movq	%rdx, %r8
               	shrq	%r8
               	xorq	%rdx, %rcx
               	andq	$0x1, %rcx
               	imulq	%rdi, %rcx
               	movq	%r8, %rdx
               	xorq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	%rdx, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0x44, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x33, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x22, %r10d
               	crc32b	%r10b, %eax
               	movl	%eax, %eax
               	movl	$0x11, %r10d
               	crc32b	%r10b, %eax
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	$0x11223344, %r10d      # imm = 0x11223344
               	crc32l	%r10d, %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
