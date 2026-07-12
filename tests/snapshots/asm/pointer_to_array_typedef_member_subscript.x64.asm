
pointer_to_array_typedef_member_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<row_via_arrow>:
               	movq	0x8(%rdi), %rax
               	movl	(%rsi), %ecx
               	sarq	$0x6, %rcx
               	andq	$0x3ffffff, %rcx        # imm = 0x3FFFFFF
               	shlq	$0xb, %rcx
               	addq	%rcx, %rax
               	movl	0x8(%rax), %eax
               	sarq	$0x6, %rax
               	andq	$0x3ffffff, %rax        # imm = 0x3FFFFFF
               	movslq	%eax, %rax
               	retq

<chained_via_dot>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	0x80c(%rax), %eax
               	sarq	$0x6, %rax
               	andq	$0x3ffffff, %rax        # imm = 0x3FFFFFF
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx), %edx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rdx
               	orq	$0x40, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx), %edx
               	andq	$-0x40, %rdx
               	orq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	movl	0x808(%rax), %ecx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rcx
               	orq	$0x240, %rcx            # imm = 0x240
               	movl	%ecx, 0x808(%rax)
               	movl	0x80c(%rax), %ecx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rcx
               	orq	$0x140, %rcx            # imm = 0x140
               	movl	%ecx, 0x80c(%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	0x8(%rax), %rax
               	movl	(%rcx), %ecx
               	sarq	$0x6, %rcx
               	andq	$0x3ffffff, %rcx        # imm = 0x3FFFFFF
               	shlq	$0xb, %rcx
               	addq	%rcx, %rax
               	movl	0x8(%rax), %eax
               	sarq	$0x6, %rax
               	andq	$0x3ffffff, %rax        # imm = 0x3FFFFFF
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	0x80c(%rax), %eax
               	sarq	$0x6, %rax
               	andq	$0x3ffffff, %rax        # imm = 0x3FFFFFF
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
