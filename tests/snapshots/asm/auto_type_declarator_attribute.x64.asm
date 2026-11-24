
auto_type_declarator_attribute.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
