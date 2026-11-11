
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
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x3(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x2(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, 0x3(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x7(%rax), %rax
               	cmpl	$0x68, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rcx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	addq	$-0x4, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x7(%rax), %rcx
               	cmpl	$0x66, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x9(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	cmpl	$0x62, %ecx
               	jne	<addr>
               	addq	$-0x8, %rax
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	movl	$0x8, %ecx
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x4, %edx
               	cmovneq	%rcx, %rax
               	retq
