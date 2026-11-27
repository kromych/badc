
attribute_cleanup.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x3, (%rcx,%rax,4)
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x2, (%rcx,%rax,4)
               	movl	$0x1, %eax
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%eax, (%rcx,%rdx,4)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0x2bc, (%rdx,%rax,4)   # imm = 0x2BC
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x0, <rip> # <addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%eax, (%rcx,%rdx,4)
               	nop
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%eax, (%rcx,%rdx,4)
               	nopl	(%rax,%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%eax, (%rdx,%rcx,4)
               	leaq	<rip>, %rcx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x32, (%rcx,%rax,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x32, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, <rip> # <addr>
               	movl	$0xc, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0xb, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0xa, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, <rip> # <addr>
               	movl	$0xc, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0xb, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0xa, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, <rip> # <addr>
               	movl	$0x29, (%rax,%rcx,4)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x28, (%rax,%rdx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x29, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x28, %edx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x29, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x28, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x29, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x28, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x1, <rip> # <addr>
               	movl	$0x15, (%rax,%rcx,4)
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x14, (%rax,%rdx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x15, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x14, %edx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	%ecx, <rip> # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x15, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, <rip> # <addr>
               	movl	$0x14, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq
