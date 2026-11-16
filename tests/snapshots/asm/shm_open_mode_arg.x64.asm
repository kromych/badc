
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
               	subq	$0xe8, %rsp
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	-0xd0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	movl	$0xc2, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rsi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x18(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rcx, %rdi
               	callq	<addr>
               	leaq	-0xd0(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x78(%rbp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	movl	$0x3, %ebx
               	xorl	%edx, %edx
               	cmpl	$0x180, %eax            # imm = 0x180
               	cmoveq	%rdx, %rbx
               	jmp	<addr>
