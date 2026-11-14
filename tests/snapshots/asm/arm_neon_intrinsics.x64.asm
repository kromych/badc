
arm_neon_intrinsics.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	movw	$0x2607, -0x40(%rbp)    # imm = 0x2607
               	movw	$0xc6c3, -0x30(%rbp)    # imm = 0xC6C3
               	movw	$0x201, -0x20(%rbp)     # imm = 0x201
               	movw	$0x6445, -0x3e(%rbp)    # imm = 0x6445
               	movw	$0xccc9, -0x2e(%rbp)    # imm = 0xCCC9
               	movw	$0xa05, -0x1e(%rbp)     # imm = 0xA05
               	movw	$0xa283, -0x3c(%rbp)    # imm = 0xA283
               	movw	$0xdad7, -0x2c(%rbp)    # imm = 0xDAD7
               	movw	$0x1a11, -0x1c(%rbp)    # imm = 0x1A11
               	movw	$0xe0c1, -0x3a(%rbp)    # imm = 0xE0C1
               	movw	$0xe0dd, -0x2a(%rbp)    # imm = 0xE0DD
               	movw	$0x3225, -0x1a(%rbp)    # imm = 0x3225
               	movw	$0x1eff, -0x38(%rbp)    # imm = 0x1EFF
               	movw	$0xeeeb, -0x28(%rbp)    # imm = 0xEEEB
               	movw	$0x5241, -0x18(%rbp)    # imm = 0x5241
               	movw	$0x5c3d, -0x36(%rbp)    # imm = 0x5C3D
               	movw	$0xf4f1, -0x26(%rbp)    # imm = 0xF4F1
               	movw	$0x7a65, -0x16(%rbp)    # imm = 0x7A65
               	movw	$0x9a7b, -0x34(%rbp)    # imm = 0x9A7B
               	movw	$0x82ff, -0x24(%rbp)    # imm = 0x82FF
               	movw	$0xaa91, -0x14(%rbp)    # imm = 0xAA91
               	movw	$0xd8b9, -0x32(%rbp)    # imm = 0xD8B9
               	movw	$0x8885, -0x22(%rbp)    # imm = 0x8885
               	movw	$0xe2c5, -0x12(%rbp)    # imm = 0xE2C5
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x30(%rbp,%rax), %r8
               	xorq	%r8, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	movzbq	-0x10(%rbp,%rax), %rdx
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x30(%rbp,%rax), %r8
               	xorq	%r8, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movzbq	-0x20(%rbp,%rax), %rsi
               	movq	%rsi, %r8
               	shlq	%r8
               	movl	$0x1d, %r9d
               	xorl	%ebx, %ebx
               	testb	$-0x80, %sil
               	cmoveq	%rbx, %r9
               	xorq	%r9, %r8
               	andq	$0xff, %r8
               	movzbq	-0x20(%rbp,%rax), %rdx
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
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
