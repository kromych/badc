
builtin_mem_transfer_inline.x64:	file format elf64-x86-64

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
               	subq	$0x428, %rsp            # imm = 0x428
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movabsq	$-0x123456789abcdf0, %rcx # imm = 0xFEDCBA9876543210
               	movq	%rax, 0x8(%rsp)
               	movq	%rcx, 0x10(%rsp)
               	movabsq	$0x5adeadbeef, %rax     # imm = 0x5ADEADBEEF
               	movq	%rax, 0x18(%rsp)
               	movl	$0x11223344, <rip> # imm = 0x11223344
                                                # <addr>
               	movl	$0x11223345, <rip> # imm = 0x11223345
                                                # <addr>
               	movl	$0x11223346, <rip> # imm = 0x11223346
                                                # <addr>
               	movl	$0x11223347, <rip> # imm = 0x11223347
                                                # <addr>
               	movl	$0x11223348, <rip> # imm = 0x11223348
                                                # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223344, %eax       # imm = 0x11223344
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223345, %eax       # imm = 0x11223345
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223346, %eax       # imm = 0x11223346
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223347, %eax       # imm = 0x11223347
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x11223348, %eax       # imm = 0x11223348
               	jne	<addr>
               	movzbq	0x1c(%rsp), %rax
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	movb	%al, <rip> # <addr>
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5a, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x4(%rsi), %rdi
               	movl	$0x10, %edx
               	callq	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movb	%al, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x4(%rdi), %rsi
               	movl	$0x10, %edx
               	callq	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xb, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xe, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x11, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x12, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x13, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	(%rax,%rax,2), %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x20(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	0x220(%rsp), %rdi
               	leaq	0x20(%rsp), %rsi
               	movl	$0x200, %edx            # imm = 0x200
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	0x220(%rsp,%rax), %rdx
               	leaq	(%rax,%rax,2), %rcx
               	andq	$0xff, %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x200, %eax            # imm = 0x200
               	jl	<addr>
               	leaq	0x220(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x18, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	nop
               	cmpb	$0x0, 0x220(%rsp,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x18, %eax
               	jb	<addr>
               	movzbq	0x238(%rsp), %rax
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	xorl	%eax, %eax
               	movq	%rax, 0x18(%rsp)
               	movabsq	$0x123456789abcdef, %rcx # imm = 0x123456789ABCDEF
               	movq	%rcx, 0x8(%rsp)
               	movabsq	$-0x123456789abcdf0, %rcx # imm = 0xFEDCBA9876543210
               	movq	%rcx, 0x10(%rsp)
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	$0x8, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
               	movl	$0x7, %eax
               	addq	$0x428, %rsp            # imm = 0x428
               	retq
