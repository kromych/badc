
anonymous_aggregates.x64:	file format elf64-x86-64

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
               	movabsq	$0x1234567890abcdef, %rax # imm = 0x1234567890ABCDEF
               	movq	%rax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	$0x90abcdef, %r11d      # imm = 0x90ABCDEF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	-0x4(%rbp), %eax
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xcafebabe, -0x8(%rbp) # imm = 0xCAFEBABE
               	movl	$0xbadf00d, -0x4(%rbp)  # imm = 0xBADF00D
               	movq	-0x8(%rbp), %rax
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x7, -0x10(%rbp)
               	movw	$0x1234, -0xc(%rbp)     # imm = 0x1234
               	movw	$0x5678, -0xa(%rbp)     # imm = 0x5678
               	movl	$0x9, -0x8(%rbp)
               	movl	-0xc(%rbp), %eax
               	cmpl	$0x56781234, %eax       # imm = 0x56781234
               	je	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
