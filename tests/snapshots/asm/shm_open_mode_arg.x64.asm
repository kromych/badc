
shm_open_mode_arg.x64:	file format elf64-x86-64

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
               	subq	$0xd0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	leaq	-0xd0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	movl	$0xc2, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testl	%r12d, %r12d
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	%r12d, %rdi
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movslq	%r12d, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x180, %eax            # imm = 0x180
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
