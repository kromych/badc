
shm_open_mode_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rbx, %rbx
               	leaq	-0x40(%rbp), %r12
               	leaq	<rip>, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movq	%r12, %rdi
               	movq	%r13, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xc2, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movslq	%r12d, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	movslq	%r12d, %rdi
               	leaq	-0xd0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movslq	%r12d, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0xd0(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpq	$0x180, %rax            # imm = 0x180
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	jmp	<addr>
