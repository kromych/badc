
file_scope_asm_local_label_branch.x64:	file format elf64-x86-64

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

<slowpath_handler>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, (%rdi)
               	retq

<main>:
               	pushq	%rax
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x3, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x2a, %eax
               	popq	%r11
               	retq
               	addb	%dl, -0x48(%rdx)

<pv_unlock>:
               	pushq	%rdx
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	lock
               	cmpxchgb	%dl, (%rdi)
               	jne	<addr>
               	popq	%rdx
               	retq

<.slowpath>:
               	pushq	%rsi
               	movzbl	%al, %esi
               	callq	<addr>
               	popq	%rsi
               	popq	%rdx
               	retq
