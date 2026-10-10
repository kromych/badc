
bool_bitfield_zero_extends.x64:	file format elf64-x86-64

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
               	movl	-0x8(%rbp), %eax
               	andq	$-0x100, %rax
               	orq	$0x10, %rax
               	movl	%eax, -0x8(%rbp)
               	movzbq	-0x7(%rbp), %rax
               	andq	$-0x2, %rax
               	orq	$0x1, %rax
               	movb	%al, -0x7(%rbp)
               	andq	$0xff, %rax
               	andq	$-0x3, %rax
               	movb	%al, -0x7(%rbp)
               	movl	-0x8(%rbp), %eax
               	andq	$-0x401, %rax           # imm = 0xFBFF
               	orq	$0x400, %rax            # imm = 0x400
               	movl	%eax, -0x8(%rbp)
               	andq	$-0x801, %rax           # imm = 0xF7FF
               	orq	$0x800, %rax            # imm = 0x800
               	movl	%eax, -0x8(%rbp)
               	movzbq	-0x7(%rbp), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	-0x7(%rbp), %rcx
               	sarq	%rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x40, %ecx
               	movzbq	-0x7(%rbp), %rdx
               	andq	$0x1, %rdx
               	shlq	$0x3, %rdx
               	subq	%rdx, %rcx
               	cmpl	$0x38, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	-0x7(%rbp), %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movzbq	-0x7(%rbp), %rcx
               	sarq	%rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	%eax, %eax
               	movq	%rax, %rcx
               	sarq	$0xb, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	sarq	$0xa, %rax
               	andq	$0x1, %rax
               	shlq	$0x3f, %rax
               	sarq	$0x3f, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
