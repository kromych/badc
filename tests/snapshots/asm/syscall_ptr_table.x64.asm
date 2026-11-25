
syscall_ptr_table.x64:	file format elf64-x86-64

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
               	subq	$0xc0, %rsp
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x10(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x20(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	callq	*%rax
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	0x28(%rsp), %r11
               	movq	%rbx, %rdi
               	movl	$0x400, %esi            # imm = 0x400
               	callq	*%r11
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	0x20(%rsp), %r11
               	movq	%rbx, %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	*%r11
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	0x18(%rsp), %rcx
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	movl	$0x1, %edx
               	movb	$0x0, %al
               	callq	*%rcx
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	movq	0x10(%rsp), %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
