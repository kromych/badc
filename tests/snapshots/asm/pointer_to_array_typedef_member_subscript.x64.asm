
pointer_to_array_typedef_member_subscript.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movl	-0x18(%rbp), %ecx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rcx
               	orq	$0x40, %rcx
               	movl	%ecx, -0x18(%rbp)
               	movl	%ecx, %ecx
               	andq	$-0x40, %rcx
               	orq	$0x1, %rcx
               	movl	%ecx, -0x18(%rbp)
               	movl	0x808(%rax), %edx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rdx
               	orq	$0x240, %rdx            # imm = 0x240
               	movl	%edx, 0x808(%rax)
               	movl	0x80c(%rax), %edx
               	movabsq	$-0xffffffc1, %r11      # imm = 0xFFFFFFFF0000003F
               	andq	%r11, %rdx
               	orq	$0x140, %rdx            # imm = 0x140
               	movl	%edx, 0x80c(%rax)
               	movl	%ecx, %ecx
               	sarq	$0x6, %rcx
               	andq	$0x3ffffff, %rcx        # imm = 0x3FFFFFF
               	shlq	$0xb, %rcx
               	addq	%rax, %rcx
               	movl	0x8(%rcx), %ecx
               	sarq	$0x6, %rcx
               	andq	$0x3ffffff, %rcx        # imm = 0x3FFFFFF
               	movslq	%ecx, %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	0x80c(%rax), %eax
               	sarq	$0x6, %rax
               	andq	$0x3ffffff, %rax        # imm = 0x3FFFFFF
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
