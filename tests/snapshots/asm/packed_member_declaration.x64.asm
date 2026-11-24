
packed_member_declaration.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movq	$0x3, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	andq	$-0xfffff01, %rax       # imm = 0xF00000FF
               	orq	$0x8000100, %rax        # imm = 0x8000100
               	movl	%eax, 0x8(%rsp)
               	movl	0xb(%rsp), %eax
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0x7ffff0, %rax         # imm = 0x7FFFF0
               	movl	%eax, 0xb(%rsp)
               	movb	$0x4, 0xe(%rsp)
               	movsbq	0x8(%rsp), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	sarq	$0x8, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$0xfff80001, %eax       # imm = 0xFFF80001
               	jne	<addr>
               	movl	0xb(%rsp), %eax
               	movq	%rax, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0x7ffff, %ecx          # imm = 0x7FFFF
               	jne	<addr>
               	andq	$-0xfffff1, %rax        # imm = 0xFF00000F
               	orq	$0xfffff0, %rax         # imm = 0xFFFFF0
               	movl	%eax, 0xb(%rsp)
               	movl	0x8(%rsp), %ecx
               	sarq	$0x8, %rcx
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0xfff80001, %ecx       # imm = 0xFFF80001
               	jne	<addr>
               	sarq	$0x4, %rax
               	shlq	$0x2c, %rax
               	sarq	$0x2c, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movsbq	0xe(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x16, %eax
               	addq	$0x18, %rsp
               	retq
