
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
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
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
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movl	$0x2bc, (%rdx,%rcx,4)   # imm = 0x2BC
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x2bc, %edx            # imm = 0x2BC
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
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x32, (%rdx,%rax,4)
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
               	movslq	<rip>, %rdx # <addr>
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0xb, (%rax,%rdx,4)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, <rip> # <addr>
               	movl	$0xa, (%rax,%rsi,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xc, %esi
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xb, %esi
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0xa, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, <rip> # <addr>
               	movl	$0xc, (%rax,%rsi,4)
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, <rip> # <addr>
               	movl	$0xb, (%rax,%rsi,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
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
               	movslq	<rip>, %rdi # <addr>
               	leaq	0x1(%rdi), %r8
               	movl	%r8d, <rip> # <addr>
               	movl	$0x28, (%rax,%rdi,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %edi # <addr>
               	cmpl	$0x29, %edi
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	cmpl	$0x28, %edi
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
               	movslq	<rip>, %rsi # <addr>
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, <rip> # <addr>
               	movl	$0x14, (%rax,%rsi,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x15, %esi
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x14, %esi
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movl	%ecx, <rip> # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, <rip> # <addr>
               	movl	$0x15, (%rax,%rcx,4)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
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
