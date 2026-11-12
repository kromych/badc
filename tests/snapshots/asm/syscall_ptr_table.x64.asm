
syscall_ptr_table.x64:	file format elf64-x86-64

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
               	subq	$0xb8, %rsp
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x28(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x20(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x10(%rsp)
               	leaq	<rip>, %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	callq	*%rax
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x400, %esi            # imm = 0x400
               	movq	0x10(%rsp), %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x90(%rbp), %rsi
               	movq	0x18(%rsp), %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %esi
               	movl	$0x1, %edx
               	movq	0x20(%rsp), %rcx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	*%rcx
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	0x28(%rsp), %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
