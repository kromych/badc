
two_d_array_param_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdi
               	movzwq	(%rdi), %rcx
               	addq	$0x2, %rdi
               	movzwq	(%rdi), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	retq
               	movslq	%esi, %rsi
               	imulq	$0xc, %rsi, %rsi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rcx
               	movq	%rdi, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	retq
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdi
               	movzbq	(%rdi), %rcx
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdi, %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x3, %rdi
               	movzbq	(%rdi), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4d0, %rsp            # imm = 0x4D0
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	movslq	%ecx, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	xorq	%rax, %rax
               	movw	%ax, (%rdx)
               	leaq	-0x400(%rbp), %rsi
               	movslq	%ecx, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	addq	$0x2, %rsi
               	movw	%ax, (%rsi)
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rcx
               	addq	$0x14, %rcx
               	movl	$0x1234, %eax           # imm = 0x1234
               	movw	%ax, (%rcx)
               	leaq	-0x400(%rbp), %rcx
               	addq	$0x16, %rcx
               	movl	$0x10, %eax
               	movw	%ax, (%rcx)
               	leaq	-0x400(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x1244, %rax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0xa, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rdx
               	movslq	%ebx, %rdi
               	imulq	$0xc, %rdi, %rax
               	addq	%rax, %rdx
               	movslq	%ecx, %rax
               	imulq	$0x64, %rdi, %rdi
               	movslq	%edi, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rdx,%rax,4)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rdx
               	movslq	%ebx, %rdi
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	movslq	%ecx, %rax
               	addq	%rax, %rdx
               	addq	$0x41, %rdi
               	movslq	%edi, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rdx)
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x4d0, %rsp            # imm = 0x4D0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
