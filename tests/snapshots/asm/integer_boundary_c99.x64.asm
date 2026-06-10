
integer_boundary_c99.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x300, %esi            # imm = 0x300
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
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
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x64, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x36, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x65, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x37, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x66, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x38, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x67, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x39, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x68, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3a, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x69, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3b, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x6a, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3c, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xff, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x6b, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3d, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	incq	%rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x6e, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x42, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	decq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x6f, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x44, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	andq	$0xff, %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x7f, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x70, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x46, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$0x7f, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x80, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x71, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x49, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x80, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	decq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x72, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4b, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movsbq	%al, %rax
               	andq	$0xff, %rax
               	xorq	$0x7f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xffff, %ebx           # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x73, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4d, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	incq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x78, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x53, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	decq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x79, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x55, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7a, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x58, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$0x7fff, %rax           # imm = 0x7FFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x8000, %rbx          # imm = 0x8000
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7b, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5b, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x8000, %rbx          # imm = 0x8000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7c, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5d, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movswq	%ax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7d, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x5f, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x2a, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7e, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x64, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x2a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xffff, %ebx           # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7f, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x69, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%ebx, %eax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x80, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x6e, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$0xffff, %rbx           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x81, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x70, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	movq	%rbx, %rax
               	cmpq	%r13, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	incq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x82, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x76, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	decq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x83, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x78, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x84, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7b, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x80000000, %rbx      # imm = 0x80000000
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x85, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7e, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x80000000, %rbx      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x86, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x80, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x80000000, %rbx      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x87, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x86, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x80000000, %r13d      # imm = 0x80000000
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x88, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	incq	%rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8c, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x8e, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	decq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8d, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x90, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8e, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x92, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r13 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8f, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x95, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	sarq	$0x1, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x90, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x9a, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	shrq	$0x1, %rax
               	movabsq	$0x4000000000000000, %r13 # imm = 0x4000000000000000
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x91, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x9d, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	shrq	$0x20, %rax
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x12c, %rbx           # imm = 0xFED4
               	movsbq	%bl, %r12
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x92, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xa0, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movsbq	%r12b, %rax
               	cmpq	$-0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x96, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xa9, %edx
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movsbq	%r12b, %rax
               	cmpq	$-0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	andq	$0xff, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x97, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xaa, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	xorq	$0xd4, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x98, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xaf, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	cmpq	$0xd4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movswq	%ax, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x99, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xb0, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movswq	%bx, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9a, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xb5, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movswq	%bx, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1ffff, %eax          # imm = 0x1FFFF
               	movswq	%ax, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9b, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xb6, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movswq	%bx, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9c, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xba, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movswq	%bx, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9d, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xbb, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movslq	%r12d, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa0, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xc2, %edx
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa1, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xc5, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	shlq	$0x1e, %rax
               	cmpq	$0x40000000, %rax       # imm = 0x40000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xaa, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xcd, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	shlq	$0x1f, %rax
               	movl	%eax, %eax
               	movl	$0x80000000, %r13d      # imm = 0x80000000
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xab, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xcf, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xac, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xd3, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xad, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0xd5, %edx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
