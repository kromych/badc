
utime_sets_times.x64:	file format elf64-x86-64

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

<mtime_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-0x90(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, %rax
               	leave
               	retq
               	movq	-0x38(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rbx
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
               	movq	%r12, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x47868c00, %rax       # imm = 0x47868C00
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
