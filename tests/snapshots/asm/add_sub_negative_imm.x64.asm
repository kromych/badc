
add_sub_negative_imm.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movl	$0xa, 0x8(%rsp)
               	movq	$0x3e8, 0x10(%rsp)      # imm = 0x3E8
               	movl	0x8(%rsp), %eax
               	addq	$-0x5, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	subl	$0xa, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	subq	$-0x7, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	addq	$-0x64, %rax
               	cmpq	$0x384, %rax            # imm = 0x384
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	subq	$-0x64, %rax
               	cmpq	$0x44c, %rax            # imm = 0x44C
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	addq	$-0xfff, %rax           # imm = 0xF001
               	cmpl	$0xfffff00b, %eax       # imm = 0xFFFFF00B
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	addq	$-0x1000, %rax          # imm = 0xF000
               	cmpl	$0xfffff00a, %eax       # imm = 0xFFFFF00A
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	$0x5, 0x18(%rsp)
               	jmp	<addr>
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rsp), %ecx
               	decq	%rcx
               	movl	%ecx, 0x18(%rsp)
               	movl	0x18(%rsp), %ecx
               	testl	%ecx, %ecx
               	jg	<addr>
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
