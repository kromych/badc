
arm_neon_intrinsics.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	pushq	%rbx
               	movw	$0x2607, 0x10(%rsp)     # imm = 0x2607
               	movw	$0xc6c3, 0x20(%rsp)     # imm = 0xC6C3
               	movw	$0x201, 0x30(%rsp)      # imm = 0x201
               	movw	$0x6445, 0x12(%rsp)     # imm = 0x6445
               	movw	$0xccc9, 0x22(%rsp)     # imm = 0xCCC9
               	movw	$0xa05, 0x32(%rsp)      # imm = 0xA05
               	movw	$0xa283, 0x14(%rsp)     # imm = 0xA283
               	movw	$0xdad7, 0x24(%rsp)     # imm = 0xDAD7
               	movw	$0x1a11, 0x34(%rsp)     # imm = 0x1A11
               	movw	$0xe0c1, 0x16(%rsp)     # imm = 0xE0C1
               	movw	$0xe0dd, 0x26(%rsp)     # imm = 0xE0DD
               	movw	$0x3225, 0x36(%rsp)     # imm = 0x3225
               	movw	$0x1eff, 0x18(%rsp)     # imm = 0x1EFF
               	movw	$0xeeeb, 0x28(%rsp)     # imm = 0xEEEB
               	movw	$0x5241, 0x38(%rsp)     # imm = 0x5241
               	movw	$0x5c3d, 0x1a(%rsp)     # imm = 0x5C3D
               	movw	$0xf4f1, 0x2a(%rsp)     # imm = 0xF4F1
               	movw	$0x7a65, 0x3a(%rsp)     # imm = 0x7A65
               	movw	$0x9a7b, 0x1c(%rsp)     # imm = 0x9A7B
               	movw	$0x82ff, 0x2c(%rsp)     # imm = 0x82FF
               	movw	$0xaa91, 0x3c(%rsp)     # imm = 0xAA91
               	movw	$0xd8b9, 0x1e(%rsp)     # imm = 0xD8B9
               	movw	$0x8885, 0x2e(%rsp)     # imm = 0x8885
               	movw	$0xe2c5, 0x3e(%rsp)     # imm = 0xE2C5
               	xorl	%eax, %eax
               	movzbq	0x10(%rsp,%rax), %rdx
               	movzbq	0x20(%rsp,%rax), %r8
               	xorq	%r8, %rdx
               	movb	%dl, 0x40(%rsp,%rax)
               	movzbq	0x10(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %r8
               	xorq	%r8, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movzbq	0x30(%rsp,%rax), %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	xorl	%ebx, %ebx
               	testb	$-0x80, %sil
               	cmoveq	%rbx, %r9
               	xorq	%r9, %r8
               	andq	$0xff, %r8
               	movzbq	0x30(%rsp,%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movl	$0x1d, %r9d
               	xorl	%ebx, %ebx
               	testb	$-0x80, %dl
               	cmoveq	%rbx, %r9
               	movq	%rsi, %rdx
               	xorq	%r9, %rdx
               	andq	$0xff, %rdx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
