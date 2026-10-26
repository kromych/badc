
file_scope_array_compound_literal_address.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpb	$0x0, 0x3(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x69, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpb	$0x0, 0x2(%rcx)
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpb	$0x0, 0x3(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	addq	$-0x4, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movsbq	0x7(%rcx), %rcx
               	cmpl	$0x66, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpb	$0x0, 0x9(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movl	0x4(%rcx), %ecx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x8, %eax
               	jmp	<addr>
