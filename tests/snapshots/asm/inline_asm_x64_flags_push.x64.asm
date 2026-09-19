
inline_asm_x64_flags_push.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x7, %ebx
               	movl	$0x7, %ecx
               	cmpq	%rcx, %rbx
               	pushfq
               	popq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	$0x40, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %ebx
               	movl	$0x9, %ecx
               	cmpq	%rcx, %rbx
               	pushfq
               	popq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	andq	$0x40, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1234, %ebx           # imm = 0x1234
               	pushw	%bx
               	popw	%ax
               	movw	%ax, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0x1234, %rax           # imm = 0x1234
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xbeef, %ebx           # imm = 0xBEEF
               	pushw	%bx
               	popw	%ax
               	movw	%ax, -0x8(%rbp)
               	movzwq	-0x8(%rbp), %rax
               	xorq	$0xbeef, %rax           # imm = 0xBEEF
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %ebx
               	movl	$0x3, %ecx
               	cmpq	%rcx, %rbx
               	pushfq
               	popq	%rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rbx
               	pushq	%rbx
               	popfq
               	pushfq
               	popq	%rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	andq	$0x40, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
