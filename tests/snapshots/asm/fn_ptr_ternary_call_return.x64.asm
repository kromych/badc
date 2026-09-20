
fn_ptr_ternary_call_return.x64:	file format elf64-x86-64

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

<fa>:
               	movq	%rdi, %rax
               	retq

<ga>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movabsq	$0x123456789, %r12      # imm = 0x123456789
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movabsq	$0x1234567890, %rdi     # imm = 0x1234567890
               	callq	<addr>
               	movq	%rax, %rdx
               	cmpq	%r12, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movabsq	$0x1234567891, %r11     # imm = 0x1234567891
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rdx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
