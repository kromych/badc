
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
               	subq	$0x38, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movq	%fs:0x0, %rax
               	movq	%rax, -0x20(%rbp)
               	cmpq	$0x0, -0x20(%rbp)
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x28(%rbp)
               	movq	%gs:<rip>, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x13579, %rax          # imm = 0x13579
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
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
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%gs:0x8, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%gs:0x18, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4444, %eax           # imm = 0x4444
               	movq	%rax, %gs:0x28
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x4444, %rax           # imm = 0x4444
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%gs:0x8, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	xorq	$0x1111, %rax           # imm = 0x1111
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	xorl	%esi, %esi
               	syscall
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, -0x28(%rbp)
               	movq	<rip>, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
