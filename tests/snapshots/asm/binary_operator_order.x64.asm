
binary_operator_order.x64:	file format elf64-x86-64

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
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x2, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movslq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	-0x1(%rax), %rcx
               	movl	%ecx, <rip> # <addr>
               	subl	$0x2, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x1, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x2, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x3, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, <rip> # <addr>
               	movl	%ecx, (%rax,%rcx,4)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%ecx, (%rax,%rdx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x4, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	xorl	%eax, %eax
               	movl	$0x1, <rip> # <addr>
               	movl	$0x1, (%rcx,%rax,4)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%eax, (%rcx,%rdx,4)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x0, (%rcx,%rax,4)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x0, (%rcx,%rax,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	retq
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x6, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x1, (%rax,%rcx,4)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x6, (%rax,%rcx,4)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x3, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x6, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x3, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x6, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x6, (%rax,%rcx,4)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, <rip> # <addr>
               	movl	%ecx, (%rax,%rcx,4)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%ecx, (%rax,%rdx,4)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x1, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x1, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	xorl	%eax, %eax
               	retq
