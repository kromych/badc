
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%fs:0x0, %rax
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%fs:0x8, %rax
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movq	%gs:<rip>, %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%gs:<rip>, %rax
               	cmpq	$0x13579, %rax          # imm = 0x13579
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x1111, 0x8(%rax)      # imm = 0x1111
               	movq	$0x3333, 0x18(%rax)     # imm = 0x3333
               	movl	$0x9e, %eax
               	movl	$0x1001, %edi           # imm = 0x1001
               	leaq	<rip>, %rsi
               	syscall
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%gs:0x8, %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%gs:0x18, %rax
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
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax
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
