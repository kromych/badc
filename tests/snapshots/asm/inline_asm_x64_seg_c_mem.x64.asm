
inline_asm_x64_seg_c_mem.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movq	%fs:0x0, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%fs:0x8, %rax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	movq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x13579, %rax          # imm = 0x13579
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1111, %ecx           # imm = 0x1111
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3333, %ecx           # imm = 0x3333
               	movq	%rcx, 0x18(%rax)
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%gs:0x8, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%gs:0x18, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4444, %eax           # imm = 0x4444
               	movq	%rax, %gs:0x28
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x4444, %rax           # imm = 0x4444
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%gs:0x8, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	xorq	$0x1111, %rax           # imm = 0x1111
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorq	%rsi, %rsi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
