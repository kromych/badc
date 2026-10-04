
bitfield_signed_read.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x1000, %rcx          # imm = 0xF000
               	orq	$0x7, %rcx
               	movl	%ecx, (%rax)
               	movzwq	(%rax), %rcx
               	andq	$-0x3001, %rcx          # imm = 0xCFFF
               	orq	$0x3000, %rcx           # imm = 0x3000
               	movw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	andq	$-0xc001, %rcx          # imm = 0xFFFF3FFF
               	orq	$0x4000, %rcx           # imm = 0x4000
               	movw	%cx, (%rax)
               	movl	(%rax), %eax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movq	%rax, %rcx
               	sarq	$0xc, %rcx
               	andq	$0x3, %rcx
               	shlq	$0x3e, %rcx
               	sarq	$0x3e, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	sarq	$0xe, %rax
               	shlq	$0x3e, %rax
               	sarq	$0x3e, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
